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
  MAX_EMOJI_SIZE = (EMOJI_SIZE * 1.5).to_i

  COLORS_SCHEMES = [
    %w(#ef7c8e #fae8e0 #b6e2d3 #d8a7b1),
    %w(#E8B4B8 #EED6D3 #A49393 #67595E),
    %w(#FBE7C6 #B4F8C8 #A0E7E5 #FFAEBC),
    %w(#E7D2CC #B9B7BD #868B8E #EEEDE7),
    %w(#B99095 #FCB5AC #B5E5CF #3D5B59),
    %w(#FFC2C7 #B6E5D8 #FBE5C8 #8FDDE7),
    %w(#F8EA8C #A4E8E0 #4CD7D0 #E1C340),
    %w(#3D550C #81B622 #ECF87F #59981A),
    %w(#04ECF0 #04D4F0 #6AF2F0 #059DC0),
    %w(#5BB0BA #C15B78 #EBF5F7 #F6C8CC),
    %w(#FABEC0 #F85C70 #F37970 #E43D40),
    %w(#EFEBE0 #FB8DA0 #FB6B90 #FB4570),
    %w(#F8C0C8 #EFE7D3 #D3BBDD #ECE3F0),
    %w(#DACAC4 #F7C9B6 #DBC39A #DAE7DD),
    %w(#ACEEF3 #FF7077 #FFE9E4 #FFB067),
    %w(#6b96c1 #ebc8b5 #fbe7ce #feafaa),
    %w(#ff738e #ffc5d1 #f6fffa #c3edd7),
    %w(#93cb9a #f0b7bd #f3e88e #99e3ec),
    %w(#c99f87 #dcc2a9 #eee6fe #907cd1),
    %w(#a0b3a8 #c6a78f #ecc8c9 #bb99b7 #e48826),
    %w(#909cac #cec3c8 #ecdab9 #efca66 #a47053),
    %w(#42281c #a35233 #d6834f #e6ae74 #f6d2ac),
    %w(#9db802 #025b0e #fd7c84 #cfcdcb #f0eeef),
    %w(#65b2c6 #c0cccc #d6c2bc #d57276 #d73d6c),
    %w(#6f6c9e #bb7db2 #d7cbd4 #e3c09b #bfd2de),
    %w(#eadbd7 #eae1ef #b8afc9 #02a0da #97cded),
    %w(#975536 #e5a484 #dddde2 #a2d4df #528c83),
    %w(#958948 #e7c8ba #dbb5bb #aa646c #7f5b5a),
    %w(#21574a #628272 #9ca18d #d39b75 #dab7a3),
    %w(#dc6d02 #fcb500 #edc596 #fd9a7e #c43d16),
    %w(#f2b9cc #523637 #bb8918 #e1dc6b #a1ae25),
    %w(#ec4f43 #fe7968 #fe948d #ffbdb3 #ffe0db),
    %w(#d2afae #a5c6b1 #f4c88c #cc883e #5e6464),
    %w(#add495 #80b7a2 #f898a4 #ffffff #ecdbc9),
    %w(#8ea926 #f9b6bd #feed85 #e5ecb9 #bba667),
    %w(#a1b2c2 #aecbcf #ccaba2 #fab5d2 #fdfdfd)
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
