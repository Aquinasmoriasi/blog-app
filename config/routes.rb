Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get "/users/:id" => "users#show", as: 'user'
  get "/users/:id/posts" => "posts#index"
  get "/users/:id/posts/:id" => "posts#show", as: 'post'
end
