class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # displays the products in alphabetical order
  end
end
