require "sequelinha"

module Interestie
  class Connection
    def self.establish
      Sequelinha.establish
    end
  end
end
