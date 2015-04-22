configure :development do
  Bundler.require :development
  Envyable.load("config/env.yml", "development")
end

use Rack::TwilioWebhookAuthentication, ENV["TWILIO_AUTH_TOKEN"], "/messages"

post "/messages" do
  twitter.update(params["Body"]) if params["From"] == ENV["MY_PHONE_NUMBER"]
  content_type "text/xml"
  "<Response/>"
end

def twitter
  @twitter ||= Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
  end
end

