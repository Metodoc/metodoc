class CompetenceIssueController < ApplicationController
    before_action :logged_in_user
    before_action  :check_permission
    before_action :load_artefact_status, :only => [:edit]

    def index
        if params[:version_id]
            @questions = CompetenceIssue.find(:all, :conditions =>{:version_id => params[:version_id]})
            @version = Version.find(params[:version_id])
        else
            redirect_to :controller => 'ontology'
        end
    end


    def edit
        if params[:id]
            @competence_issue = CompetenceIssue.find(params[:id])
            @version_id = @competence_issue.version_id
        else
            @competence_issue = CompetenceIssue.new
            #@competence_issue.artefact_status = ArtefactStatus.find(:first)
            @version_id = params[:version_id]
        end
        if request.post?
            @competence_issue.update_attributes = params[:competence_issue]
            if @competence_issue.save
                redirect_to :action => 'index', :version_id => @competence_issue.version_id
            else
                redirect_to :controller => 'authentication', :action => 'error'
            end
        end
    end

    def destroy
        question = CompetenceIssue.find(params[:id])
        if question.destroy
            redirect_to :action => 'index', :version_id => params[:version_id]
        else
            redirect_to :controller => 'authentication', :action => 'error'
        end
    end

    def show
        @questions = CompetenceIssue.find(:all, :conditions =>{:version_id=> params[:version_id]})
        @version = Version.find(params[:version_id])
    end

    def print
        @questions = CompetenceIssue.find(:all, :conditions =>{:version_id=> params[:version_id]})
        @version = Version.find(params[:version_id])
        render :layout=>'artefact'
    end

    def print_xml
        @questions = CompetenceIssue.find(:all, :conditions =>{:version_id=> params[:version_id]})
        render :xml => @questions
    end

    private

    def check_permission
        if params[:version_id]
            unless User.permission(session[:user_id], Version.find(params[:version_id]).ontology.id)
                flash[:danger] = 'Access denied'
                redirect_to root_url
            end
        else
            if params[:id]
                unless User.permission(session[:user_id], CompetenceIssue.find(params[:id]).version.ontology.id)
                    flash[:danger] = 'Access denied'
                    redirect_to root_url
                end
            end
        end
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
