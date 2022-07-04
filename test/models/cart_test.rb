require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts(:one) # arrange
  end

  # test "the truth" do
  #   assert true
  # end
  test "#total_price" do
    assert_equal 3422, @cart.total_price # assert
  end

  test "#add_product: when product already exists" do
    ruby = products(:ruby) # arrange
    cart = carts(:three) # arrange

    line_item = cart.add_product(ruby) # act
    cart.save # act
    same_line_item = cart.add_product(ruby) # act

    assert_equal 2, same_line_item.quantity # assert
    assert_equal 2400, same_line_item.total_price # assert
  end 

  test "#add_product: when product does not already exist" do
    python = products(:python) # arrange

    line_item = @cart.add_product(python) # act

    assert_equal 1, line_item.quantity # assert
    assert_equal 3000, line_item.total_price # assert
  end

  test "#decrement_line_item_quantity: when quantity > 1" do
    cart = carts(:two_rails) # arrange
    line_item = line_items(:two_rails) # arrange

    cart.decrement_line_item_quantity(line_item) #act

    assert_equal 1, line_item.quantity # assert
    assert_equal 1600, line_item.total_price # assert
  end

  test "#decrement_line_item_quantity: when quantity = 1" do
    cart = carts(:two_rails) # arrange
    line_item = line_items(:two_rails) # arrange

    cart.decrement_line_item_quantity(line_item) # act
    cart.decrement_line_item_quantity(line_item) # act - remove both

    assert_equal 0, cart.line_items.size
  end
  
  test "#decrement_line_item_quantity: when quantity = 1 and it's the only line item" do
    cart = carts(:two_rails) # arrange
    line_item = line_items(:two_rails) # arrange

    cart.decrement_line_item_quantity(line_item) # act
    cart.decrement_line_item_quantity(line_item) # act - remove both

    assert_equal false, cart.persisted?
  end
end
