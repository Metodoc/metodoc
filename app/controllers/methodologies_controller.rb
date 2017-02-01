class MethodologiesController < ApplicationController
    before_action :logged_in_user
    skip_before_action :verify_authenticity_token
    before_action :set_methodology, only: [:show, :edit, :update, :destroy]
    before_action :load_methodologias, only: [:show, :edit, :new, :details]

    # GET /methodologies
    # GET /methodologies.json
    def index
        @methodologies = Methodology.all
    end

    # GET /methodologies/1
    # GET /methodologies/1.json
    def show
        @methodology = Methodology.find(params[:id])
        @parametros = ParamsConfigTypeDoc.all
        @docEspec = DocConfigEspec.all
    end

    #===================================
    def details
        @methodology = Methodology.find(params[:id])
    end
    def search
        @methodology = Methodology.new
    end

    def newetapa
        if params[:name]
            @etapa = Methodstep.new
            @etapa.attributes = {:name => params[:name], :methodology_id=>params[:id]}
            @etapa.save	      
            redirect_to :action =>'show', :id => params[:id]
        end
    end

    def destroyEtapa
        @etapa = Methodstep.find(params[:etapa_id])
        @etapa.destroy
        redirect_to :action =>'show', :id => params[:id]
    end

    def crudDoc
        doc_type_id = params[:doc_type_id]

        if params[:etapa_id] and doc_type_id == "new"+params[:etapa_id]
            @doc = DocType.new
            @doc.attributes = { :name => params[:nameDT], :methodstep_id => params[:etapa_id]}
            @doc.save!	      
        elsif params[:nameDT] == "destroy"
            @doc = DocType.find(doc_type_id)
            @doc.destroy
        else 
            @doc = DocType.find(doc_type_id)
            @doc.attributes = { :name => params[:nameDT], :methodstep_id => params[:etapa_id]}
            @doc.save!
        end
        redirect_to :action => 'show', :id => params[:id]
    end

    def config_etapa
        #parametros da etapa
        @etapa = Methodstep.find(params[:etapa_id])
        @etapa.attributes = {:name => params[:methodstep][:name], :inlifecycle => params[:methodstep][:inlifecycle]}
        @etapa.save!

        #configuração de tipo de documento
        @etapa.doc_type.each do |d|
            DocTypeConfig.delete2(d.id)
        end

        if params[:configs_ids]
            configs_ids = params[:configs_ids].split(',')
            configs_ids.each do |c|
                doc_type_id = c.split('-')[0]
                params_config_Type_Doc_id = c.split('-')[1]

                @config = DocTypeConfig.new
                @config.attributes = { :doc_type_id => doc_type_id, :params_config_Type_Doc_id => params_config_Type_Doc_id , :answer =>true}
                @config.save!
            end

        end
        if params[:especs_ids]
            especs_ids = params[:especs_ids].split(',')
            especs_ids.each do |e|
                doc_type_id = e.split('-')[0]
                doc_config_espec_id = e.split('-')[1]
                @config = DocTypeConfig.new
                @config.attributes = { :doc_type_id => doc_type_id, :doc_config_espec_id => doc_config_espec_id , :answer =>false}
                @config.save!
            end

        end
        # a configuração acaba aqui

        redirect_to :action => "show", :id => params[:id]

    end
    #===================================

    # GET /methodologies/new
    def new
        @methodology = Methodology.new
    end

    # GET /methodologies/1/edit
    def edit
    end

    # POST /methodologies
    # POST /methodologies.json
    def create
        @methodology = Methodology.new(methodology_params)

        respond_to do |format|
            if @methodology.save
                format.html { redirect_to @methodology, notice: t(:methodologyWasSuccessfullyCreated) }
                format.json { render :show, status: :created, location: @methodology }
            else
                format.html { render :new }
                format.json { render json: @methodology.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /methodologies/1
    # PATCH/PUT /methodologies/1.json
    def update
        respond_to do |format|
            if @methodology.update(methodology_params)
                format.html { redirect_to @methodology, notice: t(:methodologyWasSuccessfullyUpdated) }
                format.json { render :show, status: :ok, location: @methodology }
            else
                format.html { render :edit }
                format.json { render json: @methodology.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /methodologies/1
    # DELETE /methodologies/1.json
    def destroy
        @methodology.destroy
        respond_to do |format|
            format.html { redirect_to methodologies_url, notice: t(:methodologyWasSuccessfullyDestroyed) }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_methodology
        @methodology = Methodology.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def methodology_params
        params.require(:methodology).permit(:name, :description).merge(user_id: session[:user_id])
    end

    def load_methodologias 
        @methodologias = Methodology.all
    end
    
     # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = t(:pleaseLoginIn)
            redirect_to login_url
        end
    end
end
