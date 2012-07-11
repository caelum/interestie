ENV["RACK_ENV"] ||= "development"

$LOAD_PATH.unshift File.expand_path("../../vendor/sequelinha/lib", __FILE__)
require "sequelinha"
Sequelinha.configure do |config|
  config.application_root = File.expand_path("../../", __FILE__)
end

$LOAD_PATH.unshift File.expand_path("../", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

require "interestie/connection"
require "interestie/application"
