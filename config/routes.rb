Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#landing'
  get '/landing', to: 'home#landing'
  
  get '/logout', to: 'user_sessions#destroy'
  delete '/logout', to: 'user_sessions#destroy'

  get '/auth/:provider/callback', to: 'user_sessions#login'
  get '/auth/failure', to: redirect('/')

  namespace :api do # /api/data
    get '/data', to: 'tests#index'
    resources :dogs
  end

  get '*path', to: "static_pages#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end

end
