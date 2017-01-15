class DocArtefactsController < ApplicationController
    before_action :set_doc_artefact, only: [:show, :edit, :update, :destroy]

    # GET /doc_artefacts
    # GET /doc_artefacts.json
    def index
        @doc_artefacts = DocArtefact.all
    end

    # GET /doc_artefacts/1
    # GET /doc_artefacts/1.json
    def show
    end

    # GET /doc_artefacts/new
    def new
        @doc_artefact = DocArtefact.new
    end

    # GET /doc_artefacts/1/edit
    def edit
    end

    # POST /doc_artefacts
    # POST /doc_artefacts.json
    def create
        @doc_artefact = DocArtefact.new(doc_artefact_params)

        respond_to do |format|
            if @doc_artefact.save
                format.html { redirect_to @doc_artefact, notice: 'Doc artefact was successfully created.' }
                format.json { render :show, status: :created, location: @doc_artefact }
            else
                format.html { render :new }
                format.json { render json: @doc_artefact.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /doc_artefacts/1
    # PATCH/PUT /doc_artefacts/1.json
    def update
        respond_to do |format|
            if @doc_artefact.update(doc_artefact_params)
                format.html { redirect_to @doc_artefact, notice: 'Doc artefact was successfully updated.' }
                format.json { render :show, status: :ok, location: @doc_artefact }
            else
                format.html { render :edit }
                format.json { render json: @doc_artefact.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /doc_artefacts/1
    # DELETE /doc_artefacts/1.json
    def destroy
        @doc_artefact.destroy
        respond_to do |format|
            format.html { redirect_to doc_artefacts_url, notice: 'Doc artefact was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc_artefact
        @doc_artefact = DocArtefact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_artefact_params
        params.fetch(:doc_artefact).permit(:answer, :document_id, :params_config_type_doc_id)
    end
end
