require 'dotenv/load'
require 'sequel/core'
require 'yaml'
require 'erb'
require 'logger'

config = YAML.load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]
postgres = "postgres://#{ENV['POSTGRES_USER']}:#{ENV['POSTGRES_PASSWORD']}@#{ENV['POSTGRES_HOST']}:" +\
           "#{ENV['POSTGRES_PORT']}/#{ENV['POSTGRES_DB']}"

DB = Sequel.connect(postgres, logger: Logger.new('log/db.log'))
puts 'DATABASE CONNECTED'
