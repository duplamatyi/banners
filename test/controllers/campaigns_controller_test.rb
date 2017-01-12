require 'test_helper.rb'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    seed_redis
  end

  test "should get campaign and display banner" do
    get campaigns_url 1
    assert_response :success
    assert_select 'h1', {count: 1, text: /10|11/}
  end


  test "should get campaign and should not display banner" do
    get campaigns_url 3
    assert_response :success
    assert_select 'h1', {count: 1, text: 'Not Found'}
  end
end
