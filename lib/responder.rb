require './config/i18n.rb'
Dir["./app/commands/**/*_command.rb"].each {|file| require file }

module Responder
  module_function

  def execute(bot, message)
    command = nil
    command = find_command(message.text) if command?(message.text)
    command = find_message(message.text) if message_command?(message.text)
    return unless command

    command.new(bot, message).execute
  end

  def find_command(name)
    command_name = to_command_name(name[1..])
    return unless Object.const_defined?(command_name)

    Object.const_get(command_name)
  end

  def find_message(mesasge)
    I18n.t('messages').each { |key, text| return Object.const_get(to_command_name(key.to_s))if text == mesasge }
    nil
  end

  def command?(name)
    name[0] == '/' && !name.include?(' ')
  end

  def message_command?(mesasge)
    I18n.t('messages').each { |_key, text| return true if text == mesasge }

    false
  end

  def to_command_name(command)
    "#{command.split('_').map { |part| part.capitalize }.join}Command"
  end
end
