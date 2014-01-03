Randr::Application.routes.draw do
  resources :users, except: [:index] do
      member do
         get "library"
      end
      # DELETE /users/:user_id/favorites/:id
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

  resource :session, only: [:new, :create, :destroy] do
    collection do
      get "welcome"
    end
  end
  
  root :to => "sessions#welcome"
end