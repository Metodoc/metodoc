class FunctionsPapersController < ApplicationController
    before_action :set_functions_paper, only: [:show, :edit, :update, :destroy]

    # GET /functions_papers
    # GET /functions_papers.json
    def index
        @functions_papers = FunctionsPaper.all
    end

    # GET /functions_papers/1
    # GET /functions_papers/1.json
    def show
    end

    # GET /functions_papers/new
    def new
        @functions_paper = FunctionsPaper.new
    end

    # GET /functions_papers/1/edit
    def edit
    end

    # POST /functions_papers
    # POST /functions_papers.json
    def create
        @functions_paper = FunctionsPaper.new(functions_paper_params)

        respond_to do |format|
            if @functions_paper.save
                format.html { redirect_to @functions_paper, notice: 'Functions paper was successfully created.' }
                format.json { render :show, status: :created, location: @functions_paper }
            else
                format.html { render :new }
                format.json { render json: @functions_paper.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /functions_papers/1
    # PATCH/PUT /functions_papers/1.json
    def update
        respond_to do |format|
            if @functions_paper.update(functions_paper_params)
                format.html { redirect_to @functions_paper, notice: 'Functions paper was successfully updated.' }
                format.json { render :show, status: :ok, location: @functions_paper }
            else
                format.html { render :edit }
                format.json { render json: @functions_paper.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /functions_papers/1
    # DELETE /functions_papers/1.json
    def destroy
        @functions_paper.destroy
        respond_to do |format|
            format.html { redirect_to functions_papers_url, notice: 'Functions paper was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_functions_paper
        @functions_paper = FunctionsPaper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def functions_paper_params
        params.fetch(:functions_paper).permit(:function_id, :paper_id)
    end
end
