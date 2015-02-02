require 'bundler'
Bundler.require

set :env, ENV['RACK_ENV'] || :development
disable :run

require './app.rb'
run Sinatra::Application
