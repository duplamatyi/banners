require 'test_helper.rb'

class UsageTest < ActionDispatch::IntegrationTest
  setup do
    seed_redis
  end

  test "should display the banners in sequence for unique visitor" do
    (0..20).to_a.each do |visit_count|
      get campaigns_url 0
      assert_response :success
      assert_select 'h1', {count: 1} do |h1|
        assert_equal h1.text.to_i, ((9 - visit_count) % 10)
      end
    end
  end
end