require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts(:one)
  end

  # test "the truth" do
  #   assert true
  # end
  test "#total_price" do
    assert_equal 3422, @cart.total_price
  end

  test "#add_product: when product already exists" do
    ruby = products(:ruby)
    line_item = @cart.add_product(ruby)
    assert_equal 2, line_item.quantity
    assert_equal 2400, line_item.total_price
  end 

  test "#add_product: when product does not already exist" do
    python = products(:python)
    line_item = @cart.add_product(python)
    assert_equal 1, line_item.quantity
    assert_equal 3000, line_item.total_price
  end
end
