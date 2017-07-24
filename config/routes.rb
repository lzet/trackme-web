Rails.application.routes.draw do
  get 'settings/getsettings'
  put 'settings/getsettings'
  get 'settings/getadministrate'
  put 'settings/getadministrate'
  root 'map#index'
  post '/', to: 'map#addpoint'
  post '/getdata', to: 'map#getpoints'
  devise_for :users, only: :sessions, controllers: {
      sessions: 'users/sessions'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
