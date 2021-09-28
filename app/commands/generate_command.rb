require './app/lib/images.rb'
require './app/models/metric.rb'
require_relative 'base_command'

class GenerateCommand < BaseCommand
  def execute
    seed = rand(1_000_000_000_000_000_000)

    Metric.insert(title: '/generate', description: seed, user_id: current_user.id)
    puts "seed=#{seed} colors=#{Images::COLORS_SCHEMES.sample(random: Random.new(seed))} background=#{Images::BACKGROUNDS.sample(random: Random.new(seed))}"

    Images::Draw.png_file(
      seed: seed,
      width: 500,
      height: 500,
      emoji_size: 160,
      colors: Images::COLORS_SCHEMES.sample(random: Random.new(seed)),
      background: Images::BACKGROUNDS.sample(random: Random.new(seed)),
      options: {}
    ) do |file_path|
      bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new(file_path, 'image/png'))
    end
  end
end
