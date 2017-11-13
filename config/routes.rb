HelenaAdministration::Engine.routes.draw do
  get 'dashboard/index'

  root 'dashboard#index'

  resource :import_survey, only: %i[new create]
  resources :surveys do
    resources :sessions
    resources :versions do
      resources :question_groups do
        resources :questions
        resource :questions do
          resources :short_texts, module: 'questions'
          resources :long_texts, module: 'questions'
          resources :static_texts, module: 'questions'
          resources :radio_groups, module: 'questions'
          resources :checkbox_groups, module: 'questions'
          resources :radio_matrices, module: 'questions'
          resources :bipolar_radio_matrices, module: 'questions'
          resources :checkbox_matrices, module: 'questions'
        end
      end
    end
  end
end
