$LOAD_PATH.unshift File.expand_path('../lib/', __FILE__)
require "interestie"

if ENV["RACK_ENV"] == "development" || ENV["RACK_ENV"] == "test"
  task :default => [:specs]
  task :specs => [:"specs:all"]
  namespace :specs do
    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new "all" do |t|
      t.pattern = "spec/**/*_spec.rb"
      t.rspec_opts = ['--color', '--format documentation', '--require spec_helper']
    end
  end
end

namespace :db do
  desc "migrations"
  task :migrate do
    migrations = File.expand_path("../db/migrate", __FILE__)
    system "sequel -m #{migrations} #{ENV["DATABASE_URL"]}"
  end
end
