## For more details refer to: http://tsamni.com/post/84515089035/sidekiq-performing-background-or-delayed-jobs-with
# config/initializers/sidekiq.rb

rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

redis_config = YAML.load(ERB.new(File.read(rails_root.to_s + '/config/redis.yml')).result)
redis_config.merge! redis_config.fetch(Rails.env, {})
redis_config.symbolize_keys!

Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{redis_config[:host]}:#{redis_config[:port]}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{redis_config[:host]}:#{redis_config[:port]}/0" }
end