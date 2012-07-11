require "sequelinha/config"
require "sequelinha/connection_url"
require "sequelinha/connection_url_factory"
require "sequelinha/adapters/sqlite"
require "sequelinha/adapters/postgres"

module Sequelinha
  def self.implementations
    @implementations ||= []
  end

  def self.register(klass, &block)
    self.implementations << klass
    self
  end

  def self.config
    @config
  end

  def self.configure
    @config ||= Config.new
    yield(@config) if block_given?

    @config.database_yml ||= "#{@config.project_root}/config/database.yml"
    @config
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
