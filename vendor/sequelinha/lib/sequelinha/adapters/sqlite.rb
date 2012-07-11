module Sequelinha
  module Adapters
    class Sqlite < ConnectionURL
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
end

