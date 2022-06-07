module CurrentCart

  private
    # if existing cart id is found, set that as the session/current cart
    def set_cart
      @cart = Cart.find(session[:cart_id])
    # else set a new session with the cart id
    rescue ActiveRecord::RecordNotFound 
      @cart = Cart.create 
      session[:cart_id] = @cart.id
    end
end
  