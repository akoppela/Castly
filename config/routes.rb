Castly::Application.routes.draw do
  # resources :download_files

  resources :invite_inquiries#, :payments, :invites, :pages, :downloads, :videos, :users
  
  # resource :sessions
  root :to => "welcome#index"
  # 
  # get 'login' => "sessions#new"
  # get 'signup' => "users#new"
  # get 'logout' => "sessions#destroy"
end
