Randr::Application.routes.draw do
  resources :users, except: [:index] do
      member do
         get "library"
      end
   end
  
  resources :authors, only: [:new, :create, :show] do
      collection do
         get "search"
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