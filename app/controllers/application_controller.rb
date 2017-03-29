class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_locale
    before_action :default_url_options
    protect_from_forgery with: :exception

    include SessionsHelper
    
    def load_artefact_status
        @artefact_status = ArtefactStatus.all.collect { |u| [u.description, u.id] }
    end

    private

    def set_locale
        if lang = request.env['HTTP_ACCEPT_LANGUAGE']
            lang = lang[/^[a-z]{2}/]
            lang = :"pt-BR" if lang == "pt"
        end
        I18n.locale = params[:locale] || lang || I18n.default_locale
    end

    def default_url_options
        { locale: I18n.locale }
    end
end
