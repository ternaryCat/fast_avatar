module Images
  module Backgrounds
    class HorizontalLines
      class << self
        SPECIFIC_OPTIONS = %i[line_height]
      end

      def initialize(chaos:, width:, height:, colors:, line_height: 25)
        @width = width
        @height = height
        @line_height = line_height.to_f

        @background = colors.sample(random: chaos)
        @color = colors.reject { |color| color == background }.sample(random: chaos)
      end

      def svg
        result = Victor::SVG.new
        result.rect x: 0, y: 0, width: width, height: height, fill: background

        lines_number.times do |number|
          points = line_points(number).map { |point| "#{point[0]}, #{point[1]}" }.join(' ')

          result.polygon fill: color, points: points
        end

        result
      end

      private

      attr_reader :width, :height, :line_height, :background, :color

      def line_points(number)
        start_y = (line_height + line_indentation) * number

        [
          [0, start_y],
          [width, start_y],
          [width, start_y + line_height],
          [0, start_y + line_height]
        ]
      end

      def line_indentation
        @line_indentation ||= (height - line_height * lines_number) / (lines_number - 1)
      end

      def lines_number
        @lines_number ||= (height / (2 * line_height)).to_i
      end
    end
  end
end
