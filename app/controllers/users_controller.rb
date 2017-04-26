class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy

    def index
        @users = User.where(activated: true).paginate(page: params[:page])
    end

    def show
        @user = User.find(params[:id])
        redirect_to root_url and return unless @user
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save # && verify_recaptcha(model: @user, message: 'Error in passing CAPTCHA.')
#            @user.send_activation_email
            flash[:info] = t(:sigupSuccess)
            redirect_to root_url
        else
            render 'new'
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = t(:sigupSuccess)
            redirect_to @user
        else
            render 'edit'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = t(:userDeleted)
        redirect_to users_url
    end

    # Extra method
    def projects
        @user = User.find(session[:user_id])
        @methodologies = Methodology.all
        @ontologies = Ontology.find_own_ontologies(session[:user_id])
        @activities = ActivityShedule.find_by_sql(["select activity_shedules.id as id, activity_shedules.name as name, activity_shedules.document_id as document_id, activity_shedules.doc_reference as doc_reference from activity_shedules inner join documents on activity_shedules.doc_reference = documents.id where activity_shedules.user_id = ? and documents.artefact_status_id = 1 union select activity_shedules.id as id, activity_shedules.name as name, activity_shedules.document_id as document_id, activity_shedules.doc_reference as doc_reference from activity_shedules where activity_shedules.user_id = ? and activity_shedules.doc_reference IS NULL",session[:user_id],session[:user_id]])
    end

    def self.permission(user_id, ontology_id)
        o = Ontology.find(ontology_id)
        o.user.each do |u|
            return true if u.id == user_id
        end
        return false
    end

    def settings
        @artefact_models = ArtefactModel.all.collect { |a| [a.name, a.id] }
        @user_option = UserOption.find_by_user_id(session[:user_id])
        if @user_option.nil?
            #            UserOption.create(:user_id => session[:user_id], :artefact_model_id => ArtefactModel.find(:first).id)
            UserOption.create(:user_id => session[:user_id], :artefact_model_id => ArtefactModel.find(1).id)
            @user_option = UserOption.find_by_user_id(session[:user_id])
        end
    end

    def choose_artefact_model
        user_option = UserOption.find_by_user_id(session[:user_id])
        user_option.artefact_model_id = params[:id]
        if user_option.save
            redirect_to :action => 'settings'
            #        else
            #            redirect_to :controller => 'authentication', :action => 'error'
        end
    end

    def atividades
        @user = User.find(session[:user_id])
        @responsables = Responsable.where(user_id: session['user_id']).all  
    end

    private

    def load_formality_degrees
        @formality_degrees = FormalityDegree.all.collect { |u| [u.name, u.id] }
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation).merge(activated: true) 
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = t(:pleaseLoginIn)
            redirect_to login_url
        end
    end

    # Confirms the correct user.
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end
end
