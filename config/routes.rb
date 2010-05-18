Crunch::Application.routes.draw do |map|
  resource :account
  resource :user_session
  resource :impersonation

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :password_reset

  root :to => 'home#index'

  namespace :admin do
    resources :users    
  end
end
