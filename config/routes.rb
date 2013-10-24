Randr::Application.routes.draw do
  resources :users, except: [:index] do
      member do
         get "library"
      end
      resources :favorites, only: [:destroy]
   end
  
  resources :authors, only: [:new, :create, :show] do
      collection do
         get "search"
      end
      collection do
         get "remove"
      end
   end

  resources :books, only: [:new, :create, :show]do
      collection do
         get "search"
      end
   end

  resource :session, only: [:new, :create, :destroy]
  
  root :to => 'users#new'
end