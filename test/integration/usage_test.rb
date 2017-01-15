require 'test_helper.rb'

class UsageTest < ActionDispatch::IntegrationTest
  setup do
    seed_redis
  end

  test "should display the banners in sequence for unique visitor" do
    # Simulates 21 visits to a campaign and checks if the banners were displayed in sequence.
    (0..20).to_a.each do |visit_count|
      get campaigns_url 0
      assert_response :success
      assert_select 'h1', {count: 1} do |h1|
        assert_equal h1.text.to_i, ((9 - visit_count) % 10)
      end
    end
  end

  test "should display the banners in separate sequence for two separate visitors" do
    sess1 = open_session
    sess2 = open_session

    sess1.get '/campaigns/0'
    assert_equal 200, sess1.response.status
    assert_match /<h1>9<\/h1>/, sess1.response.body

    sess2.get '/campaigns/0'
    assert_equal 200, sess2.response.status
    assert_match /<h1>9<\/h1>/, sess2.response.body

    sess1.get '/campaigns/0'
    assert_equal 200, sess1.response.status
    assert_match /<h1>8<\/h1>/, sess1.response.body

    sess2.get '/campaigns/0'
    assert_equal 200, sess2.response.status
    assert_match /<h1>8<\/h1>/, sess2.response.body
  end
end
