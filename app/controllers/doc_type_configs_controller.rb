class DocTypeConfigsController < ApplicationController
    before_action :set_doc_type_config, only: [:show, :edit, :update, :destroy]

    # GET /doc_type_configs
    # GET /doc_type_configs.json
    def index
        @doc_type_configs = DocTypeConfig.all
    end

    # GET /doc_type_configs/1
    # GET /doc_type_configs/1.json
    def show
    end

    # GET /doc_type_configs/new
    def new
        @doc_type_config = DocTypeConfig.new
    end

    # GET /doc_type_configs/1/edit
    def edit
    end

    # POST /doc_type_configs
    # POST /doc_type_configs.json
    def create
        @doc_type_config = DocTypeConfig.new(doc_type_config_params)

        respond_to do |format|
            if @doc_type_config.save
                format.html { redirect_to @doc_type_config, notice: 'Doc type config was successfully created.' }
                format.json { render :show, status: :created, location: @doc_type_config }
            else
                format.html { render :new }
                format.json { render json: @doc_type_config.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /doc_type_configs/1
    # PATCH/PUT /doc_type_configs/1.json
    def update
        respond_to do |format|
            if @doc_type_config.update(doc_type_config_params)
                format.html { redirect_to @doc_type_config, notice: 'Doc type config was successfully updated.' }
                format.json { render :show, status: :ok, location: @doc_type_config }
            else
                format.html { render :edit }
                format.json { render json: @doc_type_config.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /doc_type_configs/1
    # DELETE /doc_type_configs/1.json
    def destroy
        @doc_type_config.destroy
        respond_to do |format|
            format.html { redirect_to doc_type_configs_url, notice: 'Doc type config was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc_type_config
        @doc_type_config = DocTypeConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_type_config_params
        params.fetch(:doc_type_config).permit(:answer, :doc_type_id, :params_config_Type_Doc_id, :doc_config_espec_id)
    end
end
