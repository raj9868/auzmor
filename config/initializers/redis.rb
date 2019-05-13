Redis::Client::DEFAULTS[:url] = "redis://localhost:6379"
$redis_cache = Redis::Namespace.new('auzmor_inbound_sms', redis: Redis.new)
$redis_cache_rl = Redis::Namespace.new('auzmor_rate_limit', redis: Redis.new)
