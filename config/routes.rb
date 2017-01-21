Rails.application.routes.draw do


    #    mount LetsencryptPlugin::Engine, at: '/'  # It must be at root level
    root "pages#show", page: "home"
    resources :account_activations, only: [:edit]

    scope "/:locale" do

        resources :methodologies do
            collection do
                post '/config_etapa/:id', to: 'methodologies#config_etapa', as: 'methodologies_config_etapa'
                get '/newetapa/:id', to: 'methodologies#newetapa', as: 'methodologies_newetapa_get'
                post '/newetapa/:id', to: 'methodologies#newetapa', as: 'methodologies_newetapa_post'
                get '/details/:id', to: 'methodologies#details', as: 'methodologies_details'
                get '/destroyEtapa/:id', to: 'methodologies#destroyEtapa', as: 'methodologies_destroyEtapa'
                get '/destroy/:id', to: 'methodologies#destroy', as: 'methodologies_destroy_get'
                get '/crudDoc/:id', to: 'methodologies#crudDoc', as: 'methodologies_crudDoc_get'
                post '/crudDoc/:id', to: 'methodologies#crudDoc', as: 'methodologies_crudDoc_post'
            end
        end


        resources :ontologies do
            collection do
                get '/details/:id', to: 'ontologies#details', as: 'ontologies_details'
                get '/add_user/:id', to: 'ontologies#add_user', as: 'ontologies_add_user'
                get '/editing_user/:id', to: 'ontologies#editing_user', as: 'ontologies_editing_user'
                get '/show/:id', to: 'ontologies#show', as: 'ontologies_show_2'
                get '/destroy/:id', to: 'ontologies#destroy', as: 'ontologies_destroy_get'
            end
        end

        resources :params_configs
        resources :params_config_type_docs
        resources :papers
        resources :functions_papers
        resources :functions
        resources :doc_types
        resources :doc_type_configs
        resources :doc_artefacts

        get 'password_resets/new'
        get 'password_resets/edit'

        get  '/signup',  to: 'users#new'
        get    '/login',   to: 'sessions#new'
        post   '/login',   to: 'sessions#create'
        delete '/logout',  to: 'sessions#destroy'
        resources :users do
            collection do
                #                get '/users/:id/projects', to: 'users#projects', as: 'users_projects'
                get '/choose_artefact_model', to: 'users#choose_artefact_model', as: 'choose_artefact_model'
                get '/settings/:id', to: 'users#settings', as: 'users_settings_id'
                get '/settings/', to: 'users#settings', as: 'users_settings'
                get '/atividades/:id', to: 'users#atividades', as: 'users_atividades'
            end
        end

        resources :password_resets, only: [:new, :create, :edit, :update]

        post '/question/novo', to: 'question#novo', as: 'question_new'
        post '/question/resposta', to: 'question#resposta', as: 'question_resposta_post'

        get '/question/resposta', to: 'question#resposta', as: 'question_resposta_get'
        get '/question/index', to: 'question#index', as: 'question_index'
        get '/question/edit', to: 'question#edit', as: 'question_edit_get'
        post '/question/edit', to: 'question#edit', as: 'question_edit_post'

        delete '/question/destroy/:id', to: 'question#destroy', as: 'question_destroy_delete'
        get '/question/destroy/:id', to: 'question#destroy', as: 'question_destroy_get'

        get 'glossary/product_xml'
        #        get '/glossary/generate_owl', to: 'glossary#generate_owl', format: 'owl'
        get 'glossary/manual'
        post 'glossary/manual'
        post 'glossary/manualEdit'
        get 'glossary/manualEdit'


        get '/document/show/:id', to: 'document#show'
        get '/document/newespec/', to: 'document#newespec'
        get 'document/completo', to: 'document#completo', as: 'document_completo'
        get 'document/edit', to: 'document#edit', as: 'document_edit_get'
        post 'document/edit', to: 'document#edit', as: 'document_edit_post'
        get 'document/html_to_word/', to: 'document#html_to_word', format: 'docx'
        get 'document/html_to_pdf/', to: 'document#html_to_pdf', format: 'pdf'

        #         resources :versions, :except => [:show]
        delete '/versions/destroy/:id', to: 'versions#destroy'
        get '/versions/destroy/:id', to: 'versions#destroy'
        post '/versions/create', to: 'versions#create'
        get '/versions/create', to: 'versions#create'
        get '/versions/show/:id', to: 'versions#show'

        get '/activity_shedule/edit'
        post '/activity_shedule/edit'
        post '/activity_shedule/nova'
        get '/activity_shedule/destroy'

        get 'integration/index'
        get 'integration/adicionar'
        post 'integration/adicionar'
    end
end
