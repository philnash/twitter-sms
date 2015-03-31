# Twitter By SMS

This is an example of being able to send tweets and receive @mentions and direct messages by SMS using Twilio.

## How to use

You will need:

* a [Twilio account](https://www.twilio.com/try-twilio) with a phone number that can send SMS messages
* a [Twitter account](https://twitter.com) with a verified mobile phone number
* a [Twitter app](https://apps.twitter.com) with full Read, Write and Direct Messages access and a generated Access Token and Access Token Secret
* your mobile phone number

For more information on how to create these items correctly, check out the [blog post on the Twilio blog](https://www.twilio.com/blog/2015/03/send-tweets-via-sms-with-twilio-part-1.html).

Click the deploy button below and fill in the credentials.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Then SMS to your number to send a tweet!

## Run the app locally

Clone this repository then copy `config/env.yml.example` to `config/env.yml` and fill in your Twilio and Twitter credentials. You will need a [Twilio account and a number that can send and receive text messages](https://www.twilio.com/try-twilio) and a [Twitter App](https://apps.twitter.com/). Make sure your Twitter App has permissions to Read, Write and see Direct Messages.

Install the gems:

```shell
$ bundle install
```

Run the app with

```shell
$ bundle exec thin start -R config.ru
```

Get someone to @mention or DM you and you should receive an SMS alert.

### Sending tweets via SMS

You will need to make your local server available for Twilio to send a webhook to. I suggest using [ngrok](https://ngrok.com/) (see the [blog post here on how to set up ngrok for use with Twilio](https://www.twilio.com/blog/2013/10/test-your-webhooks-locally-with-ngrok.html)). Set your Messaging Request URL for your number to http://yourngroksubdomain.ngrok.com/messages. Restart the server and send an SMS to your Twilio number. You should find that you have tweeted the contents of the message.
