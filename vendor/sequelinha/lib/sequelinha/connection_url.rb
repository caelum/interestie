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
