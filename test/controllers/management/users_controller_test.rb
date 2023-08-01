require 'test_helper'

class Management::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get management_users_show_url
    assert_response :success
  end

end
