class ProcessDataTest < ActiveSupport::TestCase
  setup do
    ENV['REDIS_URL'] = ENV.key?('REDIS_URL') ? 'redis://redis:6379/2' : 'redis://localhost:6379/2'
    Campaign::Application.load_tasks
  end

  test "should push data to redis" do
    Rake::Task['campaign:build_banner_list'].invoke(Rails.root.join('test/data'))
    redis = Redis.new
    assert_equal %w(0 1), redis.keys.sort
    assert_equal %w(0 1 2 3), redis.lrange('0', 0, 4)
    assert_equal %w(0 1 2), redis.lrange('1', 0, 3)
  end
end
