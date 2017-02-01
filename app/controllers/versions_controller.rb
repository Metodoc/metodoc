class VersionsController < ApplicationController
    before_action :check_permission, :except => [:create, :show]
    before_action :load_docs
    before_action :set_version, only: [:show, :destroy]

    # GET /versions
    # GET /versions.json
    #    def index
    #        @versions = Version.all
    #    end

    # GET /versions/1
    # GET /versions/1.json
    def show
        @ontologias = Ontology.all
        @ontology = Ontology.find(params[:ontology_id])
        @version = Version.find(params[:id])
        @permisionFunction = Function.deUsuario(params[:ontology_id], session[:user_id]).include?(Function.find(1)) 
        #@etapas = Methodstep.find(:all, :conditions=>["methodsteps.methodology_id = ? AND methodsteps.inlifecycle=?",@ontology.methodology_id,true])
        @etapas = Methodstep.where("methodsteps.methodology_id = ? AND methodsteps.inlifecycle = ?", @ontology.methodology_id, true).all

        #@version_description = VersionDescription.find_by_version_id(@version.id)
        #@version_feasibility = VersionFeasibility.find_by_version_id(@version.id)
        #@version_schedule_general_status = VersionSchedule.general_status(@version.id)
        #@knowledge_acquisition = KnowledgeAcquisition.find_by_version_id(@version.id)
        #@competence_issue_general_status = CompetenceIssue.general_status(@version.id)
        #@version_evaluation = VersionEvaluation.find_by_version_id(@version.id)
        #@glossary_general_status = Term.general_status(@version.id)
        #@version_assessment = VersionAssessment.find_by_version_id(@version.id)
    end

    #    # GET /versions/new
    #    def new
    #        @version = Version.new
    #    end
    #
    #    # GET /versions/1/edit
    #    def edit
    #    end

    # POST /versions
    # POST /versions.json
    def create
        #check permission
        unless User.permission(session[:user_id], params[:ontology_id])
            flash[:notice] = 'Access denied'
            redirect_to version_path
        end

        # existing_versions = Version.find(:all, :conditions =>{:ontology_id => params[:ontology_id]})
        existing_versions = Version.where(:ontology_id => params[:ontology_id]).all
        if existing_versions.size < 1
            number = 1
        else
            number = existing_versions.size + 1
        end

        @version = Version.new(:ontology_id => params[:ontology_id], :number => number)


        if @version.save

            if number > 1
                #                previous_version_id = Version.find(:first, :conditions=>{:ontology_id => new.ontology_id,
                previous_version_id = Version.where(:ontology_id => @version.ontology_id,:number=> number-1).first.id
                glossary = Term.find_terms(previous_version_id)
                
                versionId = Version.where(number: @version.number).select("id").first
                
                for term in glossary
                    t = Term.new(:term_type => term.term_type, :artefact_status => ArtefactStatus.find(1),
                        :name => term.name, :description => term.description)
                    t.versions << Version.find(versionId) if t.save
                end
            end
            redirect_to :controller => 'ontologies', :action => 'show', :id => params[:ontology_id]
        else
            redirect_to login_path
        end
    end

    #    # PATCH/PUT /versions/1
    #    # PATCH/PUT /versions/1.json
    #    def update
    #        respond_to do |format|
    #            if @version.update(version_params)
    #                format.html { redirect_to @version, notice: 'Version was successfully updated.' }
    #                format.json { render :show, status: :ok, location: @version }
    #            else
    #                format.html { render :edit }
    #                format.json { render json: @version.errors, status: :unprocessable_entity }
    #            end
    #        end
    #    end

    # DELETE /versions/1
    # DELETE /versions/1.json
    def destroy
        version_id = @version.id
        ontology_id = @version.ontology.id
        Version.destroy_all_terms(version_id)
        if @version.destroy
            redirect_to :controller => 'ontologies', :action => 'show', :id => ontology_id
        else
            flash[:danger] = t(:errorToDestroy)
            redirect_to root_url
        end
    end

    # extra method
    def check_permission
        unless User.permission(session[:user_id], Version.find(params[:id]).ontology.id)
            flash[:danger] = t(:accessDenied)
            redirect_to root_url
        end
    end

    def load_docs
        @docs = Document.find_by_sql(["select doc_types.name as name, documents.id as id from documents inner join doc_types on documents.doc_type_id = doc_types.id inner join doc_type_configs on doc_type_configs.doc_type_id = doc_types.id inner join versions on versions.id = documents.version_id inner join ontologies on ontologies.id = versions.ontology_id where ontologies.id = ? and doc_type_configs.doc_config_espec_id = 2 union select doc_types.name as name, documents.id as id from documents inner join doc_types on documents.doc_type_id = doc_types.id inner join doc_type_configs on doc_type_configs.doc_type_id = doc_types.id inner join ontologies on ontologies.id = documents.ontology_id where ontologies.id = ? and doc_type_configs.doc_config_espec_id = 2", params[:ontology_id], params[:ontology_id]]).collect { |d| [d.name, d.id] }
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
        @version = Version.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
        params.require(:version).permit(:ontology_id, :number)
    end
end
