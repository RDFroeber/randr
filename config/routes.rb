Randr::Application.routes.draw do
  resources :authors, only: [:index, :show]
  resources :books, only: [:show] do
  end

  resources :users, except: [:index]
  resource :session, only: [:new, :create, :destroy]
      
end
