require "bundler"
Bundler.require

disable :run

require "./app.rb"
run Sinatra::Application
