Rails.application.routes.draw do
  resources :line_items
  put '/line_items/:id/decrement', to: 'line_items#decrement', as: 'decrement_line_item'

  resource :cart, only: [:destroy, :show] # specify these 2 routes only because we don't have edit/update cart functionality in our app
                          # and if user tries to edit/update then they'll see the 404 page
  root 'store#index', as: 'store_index'
  resources :products # creates the URL endpoints
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
