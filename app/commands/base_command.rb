require 'telegram/bot'
require './app/models/user.rb'

class BaseCommand
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  protected

  attr_reader :bot, :message

  def current_user
    User.find(id: message.from.id)
  end
end
