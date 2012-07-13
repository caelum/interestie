require 'rubygems'
gemfile = File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(gemfile)

ENV["RACK_ENV"] ||= "development"

require "sequelinha"
Sequelinha.configure do |config|
  config.application_root = File.expand_path("../../", __FILE__)
end

$LOAD_PATH.unshift File.expand_path("../", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

require "interestie/connection"
require "interestie/application"
