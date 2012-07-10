ENV["RACK_ENV"] ||= "development"

$LOAD_PATH.unshift File.expand_path("../", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

class ConnectionString
  def initialize(config)
    @config = config
  end

  attr_accessor :config

  def credentials
    "#{@config["username"]}:#{@config["password"]}"
  end

  def database
    "/#{@config["database"]}"
  end

  def host
    @config["host"] ? "@#{@config["host"]}" : "@localhost"
  end

  def connection
    "#{credentials}#{host}#{database}"
  end

  def string
    "#{adapter}://#{connection}"
  end
end

class SqliteString < ConnectionString
  def adapter
    @config["adapter"] == "sqlite3" ? "sqlite" : @config["adapter"]
  end

  def credentials
    ""
  end

  def database
    ""
  end

  def connection
    "#{File.expand_path("../../", __FILE__)}/#{@config["database"]}"
  end
end

class PostgresString < ConnectionString
  def adapter
    @config["adapter"] == "postgresql" ? "postgres" : @config["adapter"]
  end
end

class ConnectionStringFactory
  def self.string_for_config config
    con_string_object(config).string
  end

  private
  def self.con_string_object config
    adapters = {
      /postgre/ => proc{ PostgresString.new(config) },
      /sqlite/  => proc{ SqliteString.new(config) }
    }
    proc_to_create = adapters.select{ |regex, obj| regex =~ config["adapter"] }.values[0]
    proc_to_create.call
  end
end

def database_url
  require "yaml"
  require "erb"
  database_yml = File.expand_path("../../config/database.yml", __FILE__)
  database_config = YAML.load(ERB.new(File.read(database_yml)).result(binding))
  config = database_config[ENV["RACK_ENV"]]
  ConnectionStringFactory.string_for_config config
end

ENV["DATABASE_URL"] ||= database_url

require "interestie/connection"
require "interestie/application"
