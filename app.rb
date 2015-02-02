configure :development do
  Bundler.require :development
  Envyable.load('config/env.yml', 'development')
end

use Rack::TwilioWebhookAuthentication, ENV['TWILIO_AUTH_TOKEN'], '/messages'

twitter = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
end

twilio = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

post "/messages" do
  if params["From"] == ENV["MY_PHONE_NUMBER"]
    twitter.update params["Body"]
  end
  "<Response/>"
end

EM.schedule do
  streaming = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
  end

  streaming.user do |object|
    case object
    when Twitter::Tweet
      if object.user_mentions.any? { |mention| mention.screen_name == ENV['TWITTER_USERNAME'] }
        twilio.messages.create(
          :to => ENV['MY_PHONE_NUMBER'],
          :from => ENV['TWILIO_NUMBER'],
          :body => "@mention from #{object.user.screen_name}: #{object.text}"
        )
      end
    when Twitter::DirectMessage
      twilio.messages.create(
        :to => ENV['MY_PHONE_NUMBER'],
        :from => ENV['TWILIO_NUMBER'],
        :body => "DM from #{object.sender.screen_name}: #{object.text}"
      )
    end
  end
end
