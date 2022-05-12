require 'dotenv/load'
require 'sequel/core'
require 'yaml'
require 'erb'
require 'logger'

params = ERB.new(File.read('config/database.yml')).result
config = YAML.load(params, aliases: true)[ENV['RACK_ENV']]
postgres = "postgres://#{ENV['POSTGRES_USER']}:#{ENV['POSTGRES_PASSWORD']}@#{ENV['POSTGRES_HOST']}:" +\
           "#{ENV['POSTGRES_PORT']}/#{ENV['POSTGRES_DB']}"

DB = Sequel.connect(postgres, logger: Logger.new('log/db.log'))
puts 'DATABASE CONNECTED'
