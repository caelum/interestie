ENV["RACK_ENV"] ||= "development"

$LOAD_PATH.unshift File.expand_path("../", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

$LOAD_PATH.unshift File.expand_path("../../vendor/sequelinha/lib", __FILE__)
require "sequelinha"
Sequelinha.configure do |config|
  config.project_root = File.expand_path("../../", __FILE__)
end

# prepares interestie to run like a boss on heroku
ENV["DATABASE_URL"] ||= Sequelinha.database_url

require "interestie/connection"
require "interestie/application"
