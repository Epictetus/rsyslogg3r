require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra'

get '/' do
  "Hello world!"
end