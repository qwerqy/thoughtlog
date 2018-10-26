Tumblr.configure do |config|
  config.consumer_key = ENV['TUMBLR_KEY']
  config.consumer_secret = ENV['TUMBLR_SECRET_KEY']
  config.oauth_token = ENV['TUMBLR_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TUMBLR_OAUTH_TOKEN_SECRET']
end
