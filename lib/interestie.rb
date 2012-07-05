ENV["RACK_ENV"] ||= "development"

$LOAD_PATH.unshift File.expand_path("../", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

def database_url
  require "yaml"
  require "erb"
  database_yml = File.expand_path("../../config/database.yml", __FILE__)
  database_config = YAML.load(ERB.new(File.read(database_yml)).result(binding))
  config = database_config[ENV["RACK_ENV"]]
  host = config["host"] || "localhost"
  "#{config["adapter"]}://#{config["username"]}:#{config["password"]}@#{host}/#{config["database"]}"
end

ENV["DATABASE_URL"] ||= database_url

require "interestie/connection"
require "interestie/application"
