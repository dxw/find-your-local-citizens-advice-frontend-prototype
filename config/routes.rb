Rails.application.routes.draw do
  resources :offices
  post 'offices/search' => 'offices#search', as: :offices_search
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
