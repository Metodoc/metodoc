class ParamsConfigsController < ApplicationController
  before_action :set_params_config, only: [:show, :edit, :update, :destroy]

  # GET /params_configs
  # GET /params_configs.json
  def index
    @params_configs = ParamsConfig.all
  end

  # GET /params_configs/1
  # GET /params_configs/1.json
  def show
  end

  # GET /params_configs/new
  def new
    @params_config = ParamsConfig.new
  end

  # GET /params_configs/1/edit
  def edit
  end

  # POST /params_configs
  # POST /params_configs.json
  def create
    @params_config = ParamsConfig.new(params_config_params)

    respond_to do |format|
      if @params_config.save
        format.html { redirect_to @params_config, notice: 'Params config was successfully created.' }
        format.json { render :show, status: :created, location: @params_config }
      else
        format.html { render :new }
        format.json { render json: @params_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /params_configs/1
  # PATCH/PUT /params_configs/1.json
  def update
    respond_to do |format|
      if @params_config.update(params_config_params)
        format.html { redirect_to @params_config, notice: 'Params config was successfully updated.' }
        format.json { render :show, status: :ok, location: @params_config }
      else
        format.html { render :edit }
        format.json { render json: @params_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /params_configs/1
  # DELETE /params_configs/1.json
  def destroy
    @params_config.destroy
    respond_to do |format|
      format.html { redirect_to params_configs_url, notice: 'Params config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_params_config
      @params_config = ParamsConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def params_config_params
      params.fetch(:params_config, {})
    end
end
