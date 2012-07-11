module Sequelinha

  class Tasks
    class << self

      def load(application_root = Sequelinha.config.application_root)
        Sequelinha.config.application_root ||= aplication_root
        require migrations
      end

      def migrations(application_root = Sequelinha.config.application_root)
        tasks_dir = File.expand_path("../../tasks/", __FILE__)
        File.join(tasks_dir, "migrations")
      end

    end# class methods
  end# Tasks

end
