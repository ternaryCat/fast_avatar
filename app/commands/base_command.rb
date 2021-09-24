require 'telegram/bot'

class BaseCommand
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  protected

  attr_reader :bot, :message
end
