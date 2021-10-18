require './app/lib/images.rb'
require './app/models/metric.rb'
require './lib/callback_data.rb'
require_relative 'base_command'

class GenerateCommand < BaseCommand
  def execute(*args, **options)
    seed = args[0]&.to_i || random_seed

    Metric.insert(title: '/generate', description: seed, user_id: current_user.id)
    puts "seed=#{seed} colors=#{Images::COLORS_SCHEMES.sample(random: Random.new(seed))} " +\
         "background=#{Images::BACKGROUNDS.sample(random: Random.new(seed))}"

    Images::Draw.png_file(
      seed: seed,
      width: 500,
      height: 500,
      emoji_size: Images::MAX_EMOJI_SIZE,
      colors: Images::COLORS_SCHEMES.sample(random: Random.new(seed)),
      background: Images::BACKGROUNDS.sample(random: Random.new(seed)),
      options: {}
    ) do |file_path|
      bot.api.send_photo(
        chat_id: message.chat.id,
        photo: Faraday::UploadIO.new(file_path, 'image/png'),
        reply_markup: reply_markup(seed)
      )
    end
  end

  private

  def random_seed
    rand(1_000_000_000_000_000_000)
  end

  def reply_markup(seed)
    Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard(seed))
  end

  def keyboard(seed)
    [
      [
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: I18n.t('images.svg'),
          callback_data: CallbackData.compile('svg', seed: seed)
        ),
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: I18n.t('images.png'),
          callback_data: CallbackData.compile('png', seed: seed)
        )
      ]
    ]
  end
end
