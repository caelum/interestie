require "sequel"

module Interestie
  class Connection
    def self.establish
      Sequel.connect(ENV["DATABASE_URL"])
    end
  end
end
