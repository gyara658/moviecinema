require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get edit_post_url(posts(:one))
    assert_response :success
  end

end
