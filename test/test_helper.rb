ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

module RedisSeeder

  # Seeds Redis with test data.
  def seed_redis
    redis = Redis.current
    redis.flushdb
    redis.lpush 'banner-list:0', (0..9).to_a
    redis.lpush 'banner-list:1', [10, 11]
    redis.lpush 'banner-list:2', [12]
  end
end

# Controller and integration test that inherit from ActionDispatch::IntegrationTest
# can call the seed_redis method in their setup.
class ActionDispatch::IntegrationTest
  include RedisSeeder
end
