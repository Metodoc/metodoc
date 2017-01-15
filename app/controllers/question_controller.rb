class QuestionController < ApplicationController
    before_action :logged_in_user
    before_action :load_ontologias

    def index
        @atividade = DocConfigEspec.find(2)
        @documento = Document.find(params[:document_id])
        #        @questoes = Question.find(:all, :conditions=>['questions.document_id=?', params[:document_id]])
        @questoes = Question.where("questions.document_id = ?", params[:document_id]).all
    end

    def resposta
        #        @type_answers = TypeAnswer.find(:all)
        @type_answers = TypeAnswer.all
        @documento = Document.find(params[:document_id])
        #        @questoes = Question.find(:all, :conditions=>['questions.document_id=?', @documento.doc_reference])
        @questoes = Question.where("questions.document_id = ?", @documento.doc_reference).all
        #        @respostas = Answer.find(:all, :conditions=>['answers.document_id=?', @documento.id])
        @respostas = Answer.where("answers.document_id = ?", @documento.id).all
        if request.post?
            @questoes.each do |q|
                param = q.id
                @str = params["answer_#{param}"]
                #                @resposta = Answer.find(:first, :conditions=>['answers.question_id=? and answers.document_id=?',param, @documento.id])
                @resposta = Answer.where("answers.question_id = ? and answers.document_id = ?", param, @documento.id).first
                if @resposta.nil?
                    @resposta = Answer.new
                    @resposta.update_attributes(:document_id => @documento.id, :question_id => param)
                    if q.answer_type == 3
                        @resposta.update_attributes(:type_answer_id => @str)
                    else
                        @resposta.update_attributes(:answer => @str)
                    end 
                    @resposta.save
                else

                    if q.answer_type == 3
                        Answer.find_by_sql(['update answers set type_answer_id = ? where document_id=? and question_id = ?',@str, @documento.id, param])
                    else
                        Answer.find_by_sql(['update answers set answer = ? where document_id=? and question_id = ?',@str, @documento.id, param])
                    end

                end

            end

            if @documento.version_id.nil?
                redirect_to :controller=>'ontology', :action => 'show', :id=> @documento.ontology_id
            else
                redirect_to :controller=>'versions', :action => 'show', :id => @documento.version_id, :ontology_id =>@documento.version.ontology_id
            end
        end
    end

    def show
        @documento = Document.find(params[:document_id])
        #        @questoes = Question.find(:all, :conditions=>['questions.document_id=?', params[:document_id]])
        @questoes = Question.where("questions.document_id = ?", params[:document_id]).all

    end

    def edit
        if request.post?
            @questao = Question.find(params[:id])
            @questao.update_attributes(:question => params[:question][:question], :answer_type =>  params[:question][:answer_type])
            @questao.save
            redirect_to :action =>'index', :document_id => @questao.document_id, :message => 'Edição efetuada com sucesso'
        end
    end

    def novo
        if request.post?
            @questao = Question.new
            if params[:question][:answer_type]
                @questao.update_attributes(:question => params[:question][:question], :answer_type => params[:question][:answer_type])
            else
                @questao.update_attributes(:question => params[:question][:question])
            end
            @questao.update_attributes(:document_id => params[:document_id])
            @questao.save
            redirect_to :action =>'index', :document_id=> @questao.document_id, :message => 'Cadastro efetuado com sucesso'
        end
    end

    def destroy
        @questao = Question.find(params[:id])
        document = @questao.document_id
        @questao.destroy 
        redirect_to :action =>'index', :document_id=>document, :message => 'Deleção efetuada com sucesso'
    end
    
    private
    
    def load_ontologias
        @ontologias = Ontology.all

        if params[:ontology_id]
            @ontology = Ontology.find(params[:ontology_id])
        elsif params[:version_id] 
            @version = Version.find(params[:version_id])
            @ontology = @version.ontology
        else
            if params[:document_id]
                @documento = Document.find(params[:document_id])  
                if !@documento.ontology_id.nil?
                    @ontology = @documento.ontology
                else
                    @version = @documento.version
                    @ontology = @documento.version.ontology
                end
            end
        end
    end

    def question_params
        params.require(:question).permit(:question, :answer_type, :document_id) 
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
