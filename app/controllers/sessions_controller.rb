class SessionsController < ApplicationController

    include Recaptcha::ClientHelper # where you need recaptcha_tags
    include Recaptcha::Verify # where you need verify_recaptcha

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            if verify_recaptcha(model: user, message: 'Error in passing CAPTCHA.')
                if user.activated?
                    log_in user
                    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
                    redirect_back_or user
                else
                    message  = t(:accountActivated)
                    message += t(:checkEmail)
                    flash[:warning] = message
                    redirect_to root_url
                end
            else
                render 'new'
            end
        else
            flash.now[:danger] = t(:invalidCombination)
            render 'new'
        end
    end

    def destroy
        log_out if logged_in?
        redirect_to root_url
    end
end
