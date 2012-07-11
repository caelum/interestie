namespace :db do
  desc "migrations"
  task :migrate do
    migrations = File.join Sequelinha.config.application_root, "/db/migrate"
    system "sequel -m #{migrations} #{ENV["DATABASE_URL"]}"
  end
end
