ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

module RedisSeeder

  def seed_redis
    redis = Redis.current
    redis.flushall
    redis.lpush 'banner-list:0', (0..9).to_a
    redis.lpush 'banner-list:1', [10, 11]
    redis.lpush 'banner-list:2', [12]
  end
end

class ActionDispatch::IntegrationTest
  include RedisSeeder
end
