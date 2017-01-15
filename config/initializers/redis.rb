# Set the REDIS_URL env variable. This is used by Redis.new and Redis.current.
ENV['REDIS_URL'] ||=  Rails.configuration.redis_url

# Sets up the connection to Redis. The connection should always be retrieved with:
# - redis = Redis.current
Redis.new
