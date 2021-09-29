require_relative 'base_command'

class MenuCommand < BaseCommand
  def execute(*args, **options)
    bot.api.send_message(chat_id: message.chat.id, text: I18n.t('menu'), reply_markup: reply_markup)
  end

  private

  def reply_markup
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: keyboard, resize_keyboard: true)
  end

  def keyboard
    [[I18n.t('messages.about'), I18n.t('messages.generate')]]
  end
end
