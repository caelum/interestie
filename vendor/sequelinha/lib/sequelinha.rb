module Sequelinha
  class ConnectionURL
    def initialize(config)
      @config = config
    end

    attr_accessor :config
    def self.=~(adapter)
      nil
    end

    def username
      @config["username"]
    end

    def password
      @config["password"]
    end

    def adapter
      @config["adapter"]
    end

    def database
      @config["database"]
    end

    def host
      @config["host"] || "localhost"
    end

    def string
      final_url =  "#{self.adapter}://"
      final_url << "#{self.username}:" if self.username
      final_url << "#{self.password}" if self.password
      final_url << "@#{self.host}" if self.host
      final_url << "/#{self.database}" if self.database
    end
  end
end

module Sequelinha
  class SqliteURL < ConnectionURL
    def host
      nil
    end

    def adapter
      super == "sqlite3" ? "sqlite" : super
    end

    def database
      "#{Sequelinha.config.project_root}/#{super}"
    end

    def self.=~(adapter)
      adapter =~ /sqlite/
    end
  end
end

module Sequelinha
  class PostgresURL < ConnectionURL
    def adapter
      super == "postgresql" ? "postgres" : super
    end

    def self.=~(adapter)
      adapter =~ /postgre/
    end
  end
end

module Sequelinha
  def self.implementations
    @implementations ||= []
  end

  def self.register(klass, &block)
    self.implementations << klass
    self
  end
end

Sequelinha.register Sequelinha::PostgresURL
Sequelinha.register Sequelinha::SqliteURL

module Sequelinha
  class ConnectionURLFactory
    def self.get_instance config
      implementation(config).string
    end

    private
    def self.implementation config
      implementation = Sequelinha.implementations.find { |klass| klass =~ config["adapter"] }
      implementation.new(config)
    end
  end
end

module Sequelinha
  class Config
    def initialize(data={})
      @data = data
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      if value.class == Hash
        @data[key.to_sym] = Config.new(value)
      else
        @data[key.to_sym] = value
      end
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[$1] = args.first
      else
        self[sym]
      end
    end
  end
end

module Sequelinha
  def self.config
    @config
  end

  def self.configure
    @config ||= Config.new()
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
    ConnectionURLFactory.get_instance config
  end
end
