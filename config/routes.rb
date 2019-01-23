Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login', to: 'index#login'
  get '/callback', to: 'index#callback'
  get '/repositories', to: 'index#repositories'
  post '/create_webhook', to: 'index#create_webhook'
  post '/webhook', to: 'index#webhook'
end
