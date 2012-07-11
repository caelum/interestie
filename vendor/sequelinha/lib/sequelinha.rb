require "sequelinha/config"
require "sequelinha/connection_url"
require "sequelinha/connection_url_factory"
require "sequelinha/adapters/sqlite"
require "sequelinha/adapters/postgres"
require "sequelinha/tasks"

module Sequelinha
  def self.implementations
    @implementations ||= []
  end

  def self.register(klass, &block)
    self.implementations << klass
    self
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(self.config) if block_given?

    self.config.database_yml ||= "#{self.config.application_root}/config/database.yml"

    # prepares interestie to run like a boss on heroku
    ENV["DATABASE_URL"] ||= Sequelinha.database_url

    self.config
  end

  def self.database_url
    require "yaml"
    require "erb"
    database_yml = config["database_yml"]
    database_config = YAML.load(ERB.new(File.read(database_yml)).result(binding))
    config = database_config[ENV["RACK_ENV"] || "development"]
    ConnectionURLFactory.url_for config
  end
end

Sequelinha.register Sequelinha::Adapters::Postgres
Sequelinha.register Sequelinha::Adapters::Sqlite
