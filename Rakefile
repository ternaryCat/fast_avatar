require './config/db.rb'

namespace :db do
  task :migrate do
    puts "Migrations started"
    Sequel.extension :migration
    Sequel::Migrator.apply(DB, 'db/migrations')
    puts "Migrations ended"
  end
end
