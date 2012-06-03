Whiteboard::Application.routes.draw do
  resources :items

  resources :posts do
    member do
      put 'send_email'
      put 'post_to_blog'
    end
    resources :items, only: [ :new, :create ]
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/logout', to: 'sessions#destroy'

  root :to => 'items#index'
end
