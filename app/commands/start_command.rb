require_relative 'base_command'

class AboutCommand < BaseCommand
  def execute
    bot.api.send_message(chat_id: message.chat.id, text: I18n.t('welcome'), reply_markup: reply_markup)
  end

  private

  def reply_markup
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: keyboard, resize_keyboard: true)
  end

  def keyboard
    [[I18n.t('messages.menu')]]
  end
end
