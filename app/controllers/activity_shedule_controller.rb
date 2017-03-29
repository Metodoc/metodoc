class ActivitySheduleController < ApplicationController
    before_action :load_users, :only => [:edit]
    before_action :load_ontologias

    def nova     
        if request.post?
            @atividade = ActivityShedule.new

            @atividade.update_attributes(:name => params[:activity_shedule][:name], :user_id => params[:activity_shedule][:user_id], :description => params[:activity_shedule][:description], :deadline => params[:activity_shedule][:deadline])
            @atividade.update_attributes(:document_id=> params[:document_id])
            begin 
                @atividade.save
                rescue Exception => e
                puts e.message
            end 
            @documento = Document.find(params[:document_id])
            redirect_to :action => 'edit', :document_id=> @documento.id
        end
    end

    def edit
        @documento = Document.find(params[:document_id])
        #        @atividades = ActivityShedule.find(:all, :conditions=>['activity_shedules.document_id=?', params[:document_id]])
        @atividades = ActivityShedule.where("activity_shedules.document_id = ?", params[:document_id]).all

        if request.post?

            @atividade = ActivityShedule.find(params[:id])
            @atividade.update_attributes(:document_id => @documento.id)
            @atividade.update_attributes(:name => params[:activity_shedule][:name], :user_id => params[:activity_shedule][:user_id], :description => params[:activity_shedule][:description], :deadline => params[:activity_shedule][:deadline])
            
            begin
                @atividade.save!
                rescue Exception => e
                puts e.message
            end
            
            redirect_to :action => 'edit', :document_id => @documento.id
        end

        #redirect_to :controller=>'activity_shedule', :action => 'edit', :document_id=> @documento.ontology_id
    end

    def destroy
        @documento = Document.find(params[:document_id])
        lixo = params[:lixo].split(',')
        lixo.each do |lx_id|
            @atividade = ActivityShedule.find(lx_id)
            @atividade.destroy
        end
        redirect_to :action => 'edit', :document_id=> @documento.id
    end

    def load_ontologias
        @ontologias = Ontology.all

        if params[:ontology_id]
            @ontology = Ontology.find(params[:ontology_id])
        elsif params[:version_id] 
            @version = Version.find(params[:version_id])
            @ontology = @version.ontology
        else
            @documento = Document.find(params[:document_id])  
            if !@documento.ontology_id.nil?
                @ontology = @documento.ontology
            else
                @version = @documento.version
                @ontology = @documento.version.ontology
            end
        end
    end
    def load_users
        if params[:document_id]
            @documento = Document.find(params[:document_id])  
            if !@documento.ontology_id.nil?
                ontology_id = @documento.ontology_id
            else
                ontology_id = @documento.version.ontology_id
            end
        end
        #        @users = User.find(:all, :include=>'ontology',:conditions=>['ontology_users.ontology_id = ?', ontology_id]).collect { |u| [u.name, u.id] }
        @users = User.joins(:ontology_user).where("ontology_users.ontology_id = ?", ontology_id).all.collect { |u| [u.name, u.id] }
    end

end
