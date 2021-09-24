module Images
  module Backgrounds
    class VerticalLines
      class << self
        SPECIFIC_OPTIONS = %i[line_width]
      end

      def initialize(chaos:, width:, height:, colors:, line_width: 25)
        @width = width
        @height = height
        @line_width = line_width.to_f

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

      attr_reader :width, :height, :line_width, :background, :color

      def line_points(number)
        start_x = (line_width + line_indentation) * number

        [
          [start_x, 0],
          [start_x, height],
          [start_x + line_width, height],
          [start_x + line_width, 0]
        ]
      end

      def line_indentation
        @line_indentation ||= (width - line_width * lines_number) / (lines_number - 1)
      end

      def lines_number
        @lines_number ||= (width / (2 * line_width)).to_i
      end
    end
  end
end
