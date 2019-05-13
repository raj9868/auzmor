class RedisCache
  @logger = Rails.logger

  DEFAULT_TTL =
  DEFAULT_RL =

  class << self

    # Writes a value to cache with provided key

    def write(key, value)
      $redis_cache.set(key, value)
      $redis_cache.expire(key, 4.hours.to_i)
      true
    rescue => exc
      @logger.error { "REDIS-ERROR: write: K: #{key}. M: #{exc.message}, I: #{exc.inspect}" }
      nil
    end


    def exist?(key, options = nil)
      $redis_cache.get(key).present?
    rescue => exc
      @logger.error { "REDIS-ERROR: exists?: K: #{key.inspect}. M: #{exc.message}, I: #{exc.inspect}" }
      nil
    end

    # Writes a value to cache with provided key

    def write_rl(key, value)
      $redis_cache_rl.set(key, value)
      $redis_cache_rl.expire(key, 24.hours.to_i) if value == 1
      true
    rescue => exc
      @logger.error { "REDIS-ERROR: write: K: #{key}. M: #{exc.message}, I: #{exc.inspect}" }
      nil
    end

    # Gets value from cache with provided key

    def read_rl(key)
      $redis_cache_rl.get(key)
    rescue => exc
      @logger.error { "REDIS-ERROR: read: K: #{key}. M: #{exc.message}, I: #{exc.inspect}" }
      nil
    end

  end
end