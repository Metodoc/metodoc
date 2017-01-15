class DocumentController < ApplicationController
    before_action :logged_in_user
    before_action :load_artefact_status, :only => [:edit]
    before_action :load_users, :only => [:edit]
    before_action :load_ontologias

    def show
        @documento = Document.find(params[:id])
    end

    def completo
    end

    def edit

        if request.post?
            if params[:id]
                @documento = Document.find(params[:id])
                @documento.update(:artefact_status_id => params[:documento][:artefact_status_id])
                # @documento.save!

                # :name => params[:methodstep][:name], :inlifecycle => params[:methodstep][:inlifecycle]
                # @documento.update(:artefact_status_id => params[:documento][:artefact_status_id])
                # @documento.save

                @documento.doc_artefact.each do |d|
                    param = d.params_config_type_doc_id
                    @str=params["answer_#{param}"] 
                    DocArtefact.find_by_sql(['update doc_artefacts set answer = ? where document_id=? and params_config_type_doc_id = ?',@str, @documento.id, param])
                end

                if params[:responsable1][:user_id].present?
                    #                    @responsable1 = Responsable.find(:first, :conditions =>['responsables.level=1 and responsables.document_id=?',@documento.id])
                    @responsable1 = Responsable.where("responsables.level = 1 and responsables.document_id = ?", @documento.id).first
                    if @responsable1.nil?
                        @responsable1 = Responsable.new
                        @responsable1.attributes = { :level => 1, :document_id => @documento.id, :user_id => params[:responsable1][:user_id] }
                        @responsable1.save!
                    else
                        @responsable1.update(:level => 1, :document_id => @documento.id, :user_id => params[:responsable1][:user_id])
                        # Responsable.find_by_sql(['update responsables set user_id = ? where document_id = ? and level = 1', :user_id => params[:responsable1][:user_id], @documento.id])
                    end
                end
                
                if params[:responsable2][:user_id].present?
                    #                    @responsable2 = Responsable.find(:first, :conditions =>['responsables.level=2 and responsables.document_id=?',@documento.id])
                    @responsable2 = Responsable.where("responsables.level = 2 and responsables.document_id = ?", @documento.id).first
                    if @responsable2.nil?
                        @responsable2 = Responsable.new
                        @responsable2.attributes = { :level => 2, :document_id => @documento.id, :user_id => params[:responsable2][:user_id]}
                        @responsable2.save!
                    else
                        #                        if !@documento.id.nil?
                        #                            @responsable1.update(:level => 2, :document_id => @documento.id, :user_id => params[:responsable1][:user_id])
                        #                        end
                        Responsable.find_by_sql(['update responsables set user_id = ? where document_id = ? and level = 2', params[:responsable2][:user_id],  @documento.id])
                    end
                end    

                if @documento.version_id.nil?
                    redirect_to :controller => 'ontology', :action => 'show', :id => @documento.ontology_id
                else
                    redirect_to :controller => 'versions', :action => 'show', :id => @documento.version_id, :ontology_id=>@documento.version.ontology_id
                end
            end
        elsif params[:id]
            @documento = Document.find(params[:id])
            @permisionFunction = Function.deUsuario(params[:ontology_id], session[:user_id]).include?(Function.find(1)) 
            #            @docArtefacts = DocArtefact.find(:all, :conditions =>["doc_artefacts.document_id=?",@documento.id])
            @docArtefacts = DocArtefact.where("doc_artefacts.document_id = ?", @documento.id).all
            #            @responsable1 = Responsable.find(:first, :conditions =>['responsables.level=1 and responsables.document_id=?',@documento.id])
            @responsable1 = Responsable.where("responsables.level = 1 and responsables.document_id = ?", @documento.id).first
            #            @responsable2 = Responsable.find(:first, :conditions =>['responsables.level=2 and responsables.document_id=?',@documento.id])
            @responsable2 = Responsable.where("responsables.level = 2 and responsables.document_id = ?", @documento.id).first
        else
            @documento = Document.new
            if params[:version_id] 
                @documento.attributes = {:doc_type_id => params[:doc_type], :version_id => params[:version_id], :ontology_id => params[:ontology_id], :artefact_status_id => 1}
            else
                @documento.attributes = {:doc_type_id => params[:doc_type], :version_id => 1, :ontology_id => params[:ontology_id], :artefact_status_id => 1}
            end
            @documento.save!

            @doc_type = DocType.find(params[:doc_type])
            configEspec = @doc_type.doc_type_config.first

            #            render :text => @documento.idI
            if !configEspec.nil? and !configEspec.doc_config_espec_id.nil?

                destino = configEspec.doc_config_espec.destination.split(',')
                #                @documento.attributes = params[:document]
                #                @documento.save!


                if params[:version_id] 
                    redirect_to :controller => destino[0], :action => destino[1] , :document_id => @documento.id, :ontology_id => params[:ontology_id], :version_id => params[:version_id]
                else
                    redirect_to :controller => destino[0], :action => destino[1] , :document_id => @documento.id, :ontology_id => params[:ontology_id], :ontology_id => params[:ontology_id]
                end
            else
                @doc_type.doc_type_config.each do |d|
                    @docArtefact = DocArtefact.new
                    @docArtefact.attributes = { :document_id => @documento.id, :params_config_type_doc_id => d.params_config_Type_Doc_id, :answer => d.params_config_Type_Doc.text_start }
                    @docArtefact.save!
                end
                redirect_to :action => 'edit', :id=> @documento.id, :ontology_id => params[:ontology_id]
            end
        end
    end


    def newespec
        @documento = Document.new
        if params[:version_id] 
            @documento.attributes = { :doc_type_id => params[:doc_type], :version_id => params[:version_id], :artefact_status_id => 1 }
        else
            @documento.attributes = { :doc_type_id => params[:doc_type], :ontology_id => params[:ontology_id], :artefact_status_id => 1 }
        end
        @documento.save

        @doc_type = DocType.find(params[:doc_type])
        configEspec = @doc_type.doc_type_config.first

        if !configEspec.nil? and !configEspec.doc_config_espec_id.nil?
            destino = configEspec.doc_config_espec.destination.split(',')
            @documento.attributes = params[:document]
            @documento.save

            if params[:version_id] 
                redirect_to :controller=> destino[0], :action=> destino[1] , :document_id => @documento.id, :ontology_id => params[:ontology_id], :version_id => params[:version_id]
            else
                redirect_to :controller=> destino[0], :action=> destino[1] , :document_id => @documento.id, :ontology_id => params[:ontology_id], :ontology_id => params[:ontology_id]
            end
        end
        redirect_to :controller => 'ontologies', :action => 'show', :id => params[:ontology_id]
    end


    def destroy
        @document = Document.find(params[:id])
        @document.destroy
    end

    def load_ontologias
        @ontologias = Ontology.all
        if params[:id]
            @documento = Document.find(params[:id])  
            if !@documento.ontology_id.nil?
                @ontology = @documento.ontology
            else
                @version = @documento.version
                @ontology = @documento.version.ontology
            end
        elsif params[:ontology_id]
            @ontology = Ontology.find(params[:ontology_id])
        else 
            if params[:version_id] 
                @version = Version.find(params[:version_id])
                @ontology = @version.ontology
            end
        end
    end

    def load_users
        if params[:id]
            @documento = Document.find(params[:id])  
            if !@documento.ontology_id.nil?
                ontology_id = @documento.ontology_id
            else
                ontology_id = @documento.version.ontology_id
            end
        else
            if params[:version_id]
                @version = Version.find(params[:version_id])
                ontology_id =  @version.ontology_id
            end
        end
        #        @users = User.find(:all, :include=>'ontology',:conditions=>['ontology_users.ontology_id = ?', ontology_id]).collect { |u| [u.name, u.id] }
        @users = User.joins(:ontology_user).where("ontology_users.ontology_id = ?", ontology_id).all.collect { |u| [u.name, u.id] }
    end

    private

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end

end
