Rails.application.routes.draw do
  get '/', to: 'products#index'
  resources :products # creates the URL endpoints
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
