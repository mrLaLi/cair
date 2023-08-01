require 'test_helper'

class UpdatedataControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get updatedata_new_url
    assert_response :success
  end

  test "should get create" do
    get updatedata_create_url
    assert_response :success
  end

end
