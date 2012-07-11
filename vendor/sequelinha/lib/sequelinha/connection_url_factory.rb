module Sequelinha
  class ConnectionURLFactory
    def self.url_for config
      config["application_root"] = Sequelinha.config.application_root
      implementation(config).string
    end

    private
    def self.implementation config
      implementation = Sequelinha.implementations.find { |klass| klass =~ config["adapter"] }
      implementation.new(config)
    end
  end
end
