module ApplicationHelper
    def artefact_model_css
        UserOption.find_by_user_id(session[:user_id]).artefact_model.filename
    end

    #formatando as datas das views
    def my_date(date)
        date.strftime("%d/%m/%Y")
    end

    def language_links
        links = []
        I18n.available_locales.each do |locale|
            locale_key = "#{locale}"
            if locale == I18n.locale
                if locale_key == 'pt-BR'
                    links << link_to(image_tag("icons/bra.svg"), url_for(locale: locale.to_s), class: "icon disabled")
                else
                    links << link_to(image_tag("icons/usa.svg"), url_for(locale: locale.to_s), class: "icon")
                end
            else
                if locale_key == 'pt-BR'
                    links << link_to(image_tag("icons/bra.svg"), url_for(locale: locale.to_s), class: "icon disabled")
                else
                    links << link_to(image_tag("icons/usa.svg"), url_for(locale: locale.to_s), class: "icon")
                end
            end
        end
        links.join("\n").html_safe
    end
end