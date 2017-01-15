class ParamsConfigTypeDocsController < ApplicationController
  before_action :set_params_config_type_doc, only: [:show, :edit, :update, :destroy]

  # GET /params_config_type_docs
  # GET /params_config_type_docs.json
  def index
    @params_config_type_docs = ParamsConfigTypeDoc.all
  end

  # GET /params_config_type_docs/1
  # GET /params_config_type_docs/1.json
  def show
  end

  # GET /params_config_type_docs/new
  def new
    @params_config_type_doc = ParamsConfigTypeDoc.new
  end

  # GET /params_config_type_docs/1/edit
  def edit
  end

  # POST /params_config_type_docs
  # POST /params_config_type_docs.json
  def create
    @params_config_type_doc = ParamsConfigTypeDoc.new(params_config_type_doc_params)

    respond_to do |format|
      if @params_config_type_doc.save
        format.html { redirect_to @params_config_type_doc, notice: 'Params config type doc was successfully created.' }
        format.json { render :show, status: :created, location: @params_config_type_doc }
      else
        format.html { render :new }
        format.json { render json: @params_config_type_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /params_config_type_docs/1
  # PATCH/PUT /params_config_type_docs/1.json
  def update
    respond_to do |format|
      if @params_config_type_doc.update(params_config_type_doc_params)
        format.html { redirect_to @params_config_type_doc, notice: 'Params config type doc was successfully updated.' }
        format.json { render :show, status: :ok, location: @params_config_type_doc }
      else
        format.html { render :edit }
        format.json { render json: @params_config_type_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /params_config_type_docs/1
  # DELETE /params_config_type_docs/1.json
  def destroy
    @params_config_type_doc.destroy
    respond_to do |format|
      format.html { redirect_to params_config_type_docs_url, notice: 'Params config type doc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_params_config_type_doc
      @params_config_type_doc = ParamsConfigTypeDoc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def params_config_type_doc_params
      params.fetch(:params_config_type_doc, {})
    end
end
