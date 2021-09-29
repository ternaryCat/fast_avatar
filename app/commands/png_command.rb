require './app/lib/images.rb'
require './app/models/metric.rb'
require_relative 'base_command'

class PngCommand < BaseCommand
  def execute(*args, **options)
    Metric.insert(title: '/png', description: options[:seed], user_id: current_user.id)

    Images::Draw.png_file(
      seed: options[:seed],
      width: 500,
      height: 500,
      emoji_size: 160,
      colors: Images::COLORS_SCHEMES.sample(random: Random.new(options[:seed])),
      background: Images::BACKGROUNDS.sample(random: Random.new(options[:seed])),
      options: {}
    ) do |file_path|
      bot.api.send_document( chat_id: message.message.chat.id, document: Faraday::UploadIO.new(file_path, 'image/png'))
    end
  end
end
