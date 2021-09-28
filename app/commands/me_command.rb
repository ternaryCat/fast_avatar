class MeCommand < BaseCommand
  def execute
    bot.api.send_message(chat_id: message.chat.id, text: current_user.values.to_s)
  end
end
