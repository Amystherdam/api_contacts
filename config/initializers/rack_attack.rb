class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
  # Allow all local traffic
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end
  # Allow an IP address to make 10 requests every 10 seconds
  Rack::Attack.throttle("requests by ip", limit: 5, period: 5) do |request|
    request.ip
  end
end