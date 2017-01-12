ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

module RedisSeeder
  @@seeded = false

  def seed_redis
    return if @@seeded

    redis = Redis.new
    redis.flushall
    redis.lpush 0, (0..9).to_a
    redis.lpush 1, [10, 11]
    redis.lpush 2, [12]
    @@seeded = true
  end
end

class ActionDispatch::IntegrationTest
  include RedisSeeder
end