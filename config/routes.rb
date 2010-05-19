Crunch::Application.routes.draw do |map|
  resource :account
  resource :user_session

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :password_reset

  root :to => 'home#index'

  namespace :admin do
    resources :users
    resource :impersonation
  end
end
