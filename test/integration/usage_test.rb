require 'test_helper.rb'

class UsageTest < ActionDispatch::IntegrationTest
  setup do
    seed_redis
  end

  test "should display the banners in sequence for unique visitor" do
    for visit_count in 0..10 do
      get campaigns_url 0
      assert_response :success
      assert_select 'h1', {count: 1} do |header|
        assert_equal header.text.to_i, (visit_count % 10)
      end
    end
  end
end