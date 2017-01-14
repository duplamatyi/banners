class ProcessDataTest < ActiveSupport::TestCase
  setup do
    Banners::Application.load_tasks
  end

  test "should push data to redis" do
    redis = Redis.current
    redis.flushall
    Rake::Task['campaigns:process_data'].invoke(Rails.root.join('test/data'))
    assert_equal %w(banner-list:0 banner-list:1), redis.keys.sort
    assert_equal %w(0 1 2 3), redis.lrange('banner-list:0', 0, 4).sort
    assert_equal %w(0 1 2), redis.lrange('banner-list:1', 0, 3).sort
  end
end
