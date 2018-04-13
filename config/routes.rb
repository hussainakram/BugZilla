Rails.application.routes.draw do
  shallow do
    resources :projects do
      resources :bugs
    end
  end
  root 'home#index'
  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
