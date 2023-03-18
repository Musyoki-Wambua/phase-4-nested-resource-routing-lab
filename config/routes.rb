Rails.application.routes.draw do
  resources :items, only: [:index]

  resources :users, only: [:index, :show] do 
    resources :items, only: [:index, :show, :create]
  end

end
