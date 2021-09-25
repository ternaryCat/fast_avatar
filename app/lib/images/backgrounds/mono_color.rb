module Images
  module Backgrounds
    class MonoColor
      class << self
        SPECIFIC_OPTIONS = [].freeze
      end

      def initialize(chaos:, width:, height:, colors:)
        @width = width
        @height = height
        @background = colors.sample(random: chaos)
      end

      def svg
        result = Victor::SVG.new
        result.rect x: 0, y: 0, width: width, height: height, fill: background

        result
      end

      private

      attr_reader :width, :height, :background
    end
  end
end
