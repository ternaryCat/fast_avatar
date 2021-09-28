require './config/db.rb'
require 'sequel'

class User < Sequel::Model
  one_to_many :metrics
end
