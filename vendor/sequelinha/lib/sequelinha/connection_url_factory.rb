module Sequelinha
  class ConnectionURLFactory
    def self.url_for config
      implementation(config).string
    end

    private
    def self.implementation config
      implementation = Sequelinha.implementations.find { |klass| klass =~ config["adapter"] }
      implementation.new(config)
    end
  end
end
