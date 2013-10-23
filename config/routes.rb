Randr::Application.routes.draw do
  resources :users, except: [:index] 
  # remove unused paths
  resources :authors, only: [:index, :new, :create, :show] do
      collection do
         get "search"
      end
   end

  # resources :books, only: [:show]
  resources :favorites, only: [:create, :edit, :destroy]

  resource :session, only: [:new, :create, :destroy]
  
  root :to => 'users#new'
end