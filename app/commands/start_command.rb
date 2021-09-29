require_relative 'base_command'

class StartCommand < BaseCommand
  def execute(*args, **options)
    user = User.insert(user_params(message.from)) unless current_user

    bot.api.send_message(chat_id: message.chat.id, text: I18n.t('welcome'), reply_markup: reply_markup)
  end

  private

  def reply_markup
    Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: keyboard, resize_keyboard: true)
  end

  def keyboard
    [[I18n.t('messages.menu')]]
  end

  def user_params(from)
    from.attributes.slice(:username, :first_name, :last_name, :language_code).merge(uid: from.id)
  end
end
