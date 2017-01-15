class OntologiesController < ApplicationController
    before_action :logged_in_user
    skip_before_action :verify_authenticity_token
    before_action :check_permission, :except =>[:index, :search, :details, :edit, :new, :create]
    before_action :load_formality_degrees, :only => [:new, :index, :edit, :create, :update]
    before_action :load_methodologies, :only => [:new, :index, :edit, :create, :update]
    before_action :load_ontologias
    before_action :set_ontology, only: [:show, :edit, :update, :destroy]

    # GET /ontologies
    # GET /ontologies.json
    def index
        #        @ontologies = Ontology.all
        @ontologies = Ontology.find_own_ontologies(session[:user_id])
    end

    # GET /ontologies/1
    # GET /ontologies/1.json
    def show
        @ontology = Ontology.find(params[:id])
        #1 é o id da função em questão
        @permisionFunction = Function.deUsuario(params[:id], session[:user_id]).include?(Function.find(1)) 
        #        @etapas = Methodstep.find(:all, :conditions=>["methodsteps.methodology_id = ? AND methodsteps.inlifecycle=?",@ontology.methodology_id,false])
        @etapas = Methodstep.where("methodsteps.methodology_id = ? AND methodsteps.inlifecycle = ?", @ontology.methodology_id, false).all #alterei para true
        #@project_description = ProjectDescription.find_by_ontology_id(params[:id])
        #@project_feasibility  = ProjectFeasibility.find_by_ontology_id(params[:id])
        #        @versions = Version.find(:all, :conditions =>{:ontology_id => params[:id]}, :order => "number DESC")
        @versions = Version.where(ontology_id: params[:id]).order("number DESC").all
    end

    # GET /ontologies/new
    def new
        @ontology = Ontology.new
        @ontologyUser = OntologyUser.new
    end

    # GET /ontologies/1/edit
    def edit
    end

    # =============================== extra method =======================

    def search
        if params[:string]
            @like = "%"
            @like = @like.concat(params[:string][:key].concat("%"))
            if params[:ontology] == "name"
#                @ontologies = Ontology.find(:all, :conditions=>["ontologies.name like ? AND ontologies.visible=?",@like,true])
                @ontologies = Ontology.where("ontologies.name like ? AND ontologies.visible=?",@like,true).all
            end
            if params[:ontology] == "project_name"
#                @ontologies = Ontology.find(:all, :conditions=>["ontologies.project_name like ? AND ontologies.visible=?",@like,true])
                @ontologies = Ontology.where("ontologies.project_name like ? AND ontologies.visible=?",@like,true).all
            end
            if params[:ontology] == "domain"
                @ontologies = Ontology.where("ontologies.domain like ? AND ontologies.visible=?",@like,true).all
            end
        end
    end

    def details
        @ontology = Ontology.find(params[:id])
        #        @current_version = Version.find(:first, :order=>"id desc", :conditions =>{:ontology_id => @ontology.id})
        @current_version = Version.where(ontology_id: @ontology.id).order("id desc").first
    end

    def add_user
        @ontology = Ontology.find(params[:id])
        #Vamos considerar que pra adicionar colaborador é necessario participar da ontologia(como adm ou gestor)
        if params[:option]=="search"
            @like = "%"
            @like = @like.concat(params[:string].concat("%"))
            if params[:key] == "user"
                @ontologyUser = OntologyUser.find_by_sql(["select * from ontology_users inner join users on user_id =users.id inner join papers on papers.id = paper_id where users.name like ? and ontology_id = ?", @like, params[:id]])
            else
                @ontologyUser = OntologyUser.find_by_sql(["select * from ontology_users inner join users on user_id =users.id inner join papers on papers.id = paper_id where papers.paper like ? and ontology_id = ?", @like, params[:id]])
            end
        else
            @ontologyUser = OntologyUser.find_own_ontologies(params[:id])
        end
        @users = User.all
        @papers = Paper.all
    end

    def editing_user
        ontology = Ontology.find(params[:id])
        if params[:option]=="add"
            papersUser = params[:papers_ids].split(',')
            OntologyUser.delete2(params[:id],params[:user_id])
            papersUser.each do |p|
                @ontologyUser = OntologyUser.new
                @ontologyUser.update_attributes(:ontology_id => params[:id], :user_id => params[:user_id], :paper_id => p) 
                @ontologyUser.save
                #ontology.users << User.find(params[:user_id]) unless User.find(params[:user_id]).nil?
            end
        else
            if params[:option]=="del"
                OntologyUser.delete1(params[:id],params[:user_id],params[:paper_id])
            end
        end
        redirect_to :action =>'add_user', :id => ontology.id
    end
    # ====================================================================

    # POST /ontologies
    # POST /ontologies.json
    def create
        @ontology = Ontology.new(ontology_params)

        respond_to do |format|
            if @ontology.save
                ontoId = Ontology.where(name: @ontology.name).select("id").first
                userId = session[:user_id];
                OntologyUser.find_by_sql("insert into ontology_users (ontology_id, user_id, paper_id) values ('#{ontoId.id}', '#{userId}', 1)")
                #                @ontologyUser.save
                format.html { redirect_to @ontology, notice: 'Ontology was successfully created.' }
                format.json { render :show, status: :created, location: @ontology }
            else
                format.html { render :new }
                format.json { render json: @ontology.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /ontologies/1
    # PATCH/PUT /ontologies/1.json
    def update
        respond_to do |format|
            if @ontology.update(ontology_params)
                format.html { redirect_to @ontology, notice: 'Ontology was successfully updated.' }
                format.json { render :show, status: :ok, location: @ontology }
            else
                format.html { render :edit }
                format.json { render json: @ontology.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /ontologies/1
    # DELETE /ontologies/1.json
    def destroy
        @ontology.destroy
        respond_to do |format|
            format.html { redirect_to ontologies_url, notice: 'Ontology was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_ontology
        @ontology = Ontology.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ontology_params
        params.require(:ontology).permit(:project_name, :name, :domain, :visible, :formality_degree_id, :methodology_id)
    end

    #============== extra method ==============

    def load_formality_degrees
        @formality_degrees = FormalityDegree.all.collect { |u| [u.name, u.id] }
    end
    def load_methodologies
        @metodologias = Methodology.all.collect { |u| [u.name, u.id] }
    end

    def load_ontologias
        @ontologias = Ontology.all
    end

    def check_permission
        unless User.permission(session[:user_id], params[:id])
            flash[:danger] = 'Access denied'
            redirect_to root_url
        end
    end

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end
end
