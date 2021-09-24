require 'base64'
require_relative 'images/draw.rb'
require_relative 'images/backgrounds/circles_grid.rb'
require_relative 'images/backgrounds/horizontal_lines.rb'
require_relative 'images/backgrounds/mono_color.rb'
require_relative 'images/backgrounds/oblique_lines.rb'
require_relative 'images/backgrounds/vertical_lines.rb'

module Images
  class ColorsNotEnough < StandardError; end
  class InvalidSize < StandardError; end
  class MissingOptions < StandardError; end

  # pixels
  EMOJI_SIZE = 160
  MIN_EMOJI_SIZE = EMOJI_SIZE * 0.5
  MAX_EMOJI_SIZE = EMOJI_SIZE * 2

  COLORS_SCHEMES = [
    %w(#ef7c8e #fae8e0 #b6e2d3 #d8a7b1),
    %w(#E8B4B8 #EED6D3 #A49393 #67595E),
    %w(#FBE7C6 #B4F8C8 #A0E7E5 #FFAEBC),
    %w(#E7D2CC #B9B7BD #868B8E #EEEDE7),
    %w(#05445E #189AB4 #75E6DA #D4F1F4),
    %w(#145DA0 #0C2D48 #2E8BC0 #B1D4E0),
    %w(#B99095 #FCB5AC #B5E5CF #3D5B59),
    %w(#FFC2C7 #B6E5D8 #FBE5C8 #8FDDE7),
    %w(#F8EA8C #A4E8E0 #4CD7D0 #E1C340),
    %w(#3D550C #81B622 #ECF87F #59981A),
    %w(#F2C5E0 #D43790 #EC8FD0 #870A30),
    %w(#04ECF0 #04D4F0 #6AF2F0 #059DC0),
    %w(#5BB0BA #C15B78 #EBF5F7 #F6C8CC),
    %w(#FABEC0 #F85C70 #F37970 #E43D40),
    %w(#76B947 #B1D8B7 #2F5233 #94C973),
    %w(#EFEBE0 #FB8DA0 #FB6B90 #FB4570),
    %w(#F8C0C8 #EFE7D3 #D3BBDD #ECE3F0),
    %w(#DACAC4 #F7C9B6 #DBC39A #DAE7DD),
    %w(#ACEEF3 #FF7077 #FFE9E4 #FFB067)
  ]

  BACKGROUNDS = [
    Backgrounds::CirclesGrid,
    Backgrounds::HorizontalLines,
    Backgrounds::MonoColor,
    Backgrounds::ObliqueLines,
    Backgrounds::VerticalLines
  ]

  EMOJIS = Dir.glob('./app/lib/images/assets/*').map do |emoji|
    "data:image/png;base64,#{Base64.strict_encode64(File.open(emoji).read)}"
  end
end
