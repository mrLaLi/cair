require 'test_helper'

class Verification::RequestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get verification_request_index_url
    assert_response :success
  end

end
