require './app/lib/images.rb'
require './app/models/metric.rb'
require_relative 'base_command'

class SvgCommand < BaseCommand
  def execute(*args, **options)
    Metric.insert(title: '/svg', description: options[:seed], user_id: current_user.id)

    file = Images::Draw.svg_file(
      seed: options[:seed],
      width: 500,
      height: 500,
      emoji_size: 160,
      colors: Images::COLORS_SCHEMES.sample(random: Random.new(options[:seed])),
      background: Images::BACKGROUNDS.sample(random: Random.new(options[:seed])),
      options: {}
    )

    bot.api.send_document(
      chat_id: message.message.chat.id,
      document: Faraday::UploadIO.new(file.path, 'image/svg+xml')
    )
  end
end
