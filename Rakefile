require "twilio-ruby"

namespace :twilio do
  desc "Setup the Twilio phone number with the right callback url"
  task :setup do
    phone_number = ENV["TWILIO_NUMBER"]
    url = "https://#{ENV["HEROKU_APP_NAME"]}.herokuapp.com/messages"
    client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
    numbers = client.incoming_phone_numbers.list(phone_number: phone_number)
    if numbers.any?
      twilio_number = numbers.first
      twilio_number.update(sms_url: url)
    end
  end
end
