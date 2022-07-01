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
end
