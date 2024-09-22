require "test_helper"

class Public::CartItemControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_cart_item_index_url
    assert_response :success
  end
end
