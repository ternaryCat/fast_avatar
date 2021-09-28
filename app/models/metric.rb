require './config/db.rb'
require 'sequel'

class Metric < Sequel::Model
  many_to_one :user
end
