require 'test_helper'

class ForgottenPasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get forgotten_password_new_url
    assert_response :success
  end

  test "should get create" do
    get forgotten_password_create_url
    assert_response :success
  end

  test "should get show" do
    get forgotten_password_show_url
    assert_response :success
  end

end
