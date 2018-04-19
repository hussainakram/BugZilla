Rails.application.routes.draw do
  shallow do
    resources :projects do
      get  'users', to: 'user_projects#index', as: 'users'
      resources :user_projects, only: [:destroy]
      resources :bugs do
        member do
          post :assign
          post :resolve
        end
        get '/add_comment', to: "bug#add_comment"
      end
    end
  end
  root 'home#index'
  get 'home/index'

  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
