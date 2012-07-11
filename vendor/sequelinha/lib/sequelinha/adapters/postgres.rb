module Sequelinha
  module Adapters
    class Postgres < ConnectionURL
      def adapter
        super == "postgresql" ? "postgres" : super
      end

      def self.=~(adapter)
        adapter =~ /postgre/
      end
    end
  end
end

