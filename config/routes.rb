Rails.application.routes.draw do
  resources :projects do
    resources :bugs
  end
  root 'home#index'
  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
