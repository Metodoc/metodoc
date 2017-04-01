class PasswordResetsController < ApplicationController
    before_action :get_user,   only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update]    # Case (1)
    
#    include Recaptcha::ClientHelper # where you need recaptcha_tags
    include Recaptcha::Verify # where you need verify_recaptcha

    def new
    end

    def create
        @user = User.find_by(email: params[:password_reset][:email].downcase)
        if @user
            if verify_recaptcha(model: @user, message: 'Error in passing CAPTCHA.')
                @user.create_reset_digest
                @user.send_password_reset_email
                flash[:info] = t(:emailSentWithPasswordResetInstructions)
                redirect_to root_url
            else
                render 'new'
            end
        else
            flash.now[:danger] = t(:emailAddressNotFound)
            render 'new'
        end
    end

    def edit
    end

    def update
        if params[:user][:password].empty?                  # Case (3)
            @user.errors.add(:password, "can't be empty")
            render 'edit'
        elsif @user.update_attributes(user_params)          # Case (4)
            log_in @user
            @user.update_attribute(:reset_digest, nil)
            flash[:success] = t(:asswordHasBeenReset)
            redirect_to @user
        else
            render 'edit'                                     # Case (2)
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
        @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
        unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
            redirect_to root_url
        end
    end

    # Checks expiration of reset token.
    def check_expiration
        if @user.password_reset_expired?
            flash[:danger] = t(:passwordResetHasExpired)
            redirect_to new_password_reset_url
        end
    end
end
