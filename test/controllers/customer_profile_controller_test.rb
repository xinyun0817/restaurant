require 'test_helper'

class CustomerProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_profile_index_url
    assert_response :success
  end

  test "should get edit" do
    get customer_profile_edit_url
    assert_response :success
  end

  test "should get update" do
    get customer_profile_update_url
    assert_response :success
  end

end
