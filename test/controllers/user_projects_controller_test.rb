require 'test_helper'

class UserProjectsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get user_projects_index_url
    assert_response :success
  end

  test 'should get show' do
    get user_projects_show_url
    assert_response :success
  end

  test 'should get destroy' do
    get user_projects_destroy_url
    assert_response :success
  end
end
