require './config/i18n.rb'
require_relative 'callback_data.rb'
Dir["./app/commands/**/*_command.rb"].each {|file| require file }

module Responder
  module_function

  def execute(bot, message)
    command = nil
    params = []
    options = {}
    if message.is_a?(Telegram::Bot::Types::CallbackQuery)
      command_name, options = CallbackData.decompile(message.data)
      command = find_command(command_name)
    end

    if message.is_a?(Telegram::Bot::Types::Message) && message.text
      command = find_message(message.text) if message_command?(message.text)
      if command?(message.text)
        command = find_command(message.text[1..])
        params = command_params(message.text)
      end
    end
    return unless command

    command.new(bot, message).execute(*params, **options)
  end

  def find_command(name)
    command_name = to_command_name(name)
    return unless Object.const_defined?(command_name)

    Object.const_get(command_name)
  end

  def find_message(mesasge)
    I18n.t('messages').each { |key, text| return Object.const_get(to_command_name(key.to_s))if text == mesasge }
    nil
  end

  def command?(name)
    name[0] == '/'
  end

  def message_command?(mesasge)
    I18n.t('messages').each { |_key, text| return true if mesasge == text }

    false
  end

  def to_command_name(command)
    "#{command.split(' ').first.split('_').map { |part| part.capitalize }.join}Command"
  end

  def command_params(message)
    message.split(' ').slice(1..)
  end
end
