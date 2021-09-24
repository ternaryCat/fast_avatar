module Images
  module Backgrounds
    class ObliqueLines
      class << self
        SPECIFIC_OPTIONS = %i[line_width line_indentation line_area]
      end

      def initialize(chaos:, width:, height:, colors:, line_width: 25, line_indentation: 25, line_area: 450)
        @width = width
        @height = height
        @line_width = line_width
        @line_indentation = line_indentation
        @line_area = line_area

        @background = colors.sample(random: chaos)
        @color = colors.reject { |color| color == background }.sample(random: chaos)
      end

      def svg
        result = Victor::SVG.new
        result.rect x: 0, y: 0, width: width, height: height, fill: background

        lines_number.times do |number|
          result << line(number)
        end

        result
      end

      private

      attr_reader :width, :height, :line_width, :line_indentation, :line_area, :background, :color

      def lines_number
        @lines_number ||= (lines_area / line_step).ceil
      end

      def line(number)
        result = Victor::SVG.new
        points = line_points(number).map { |point| "#{point[0]}, #{point[1]}" }.join(' ')

        result.polygon fill: color, points: points
        result
      end

      def line_points(number)
        start_x = x(number)

        [
          [start_x, 0],
          [start_x + line_width, 0],
          [start_x + line_area + line_width, height],
          [start_x + line_area, height]
        ]
      end

      def x(number)
        line_step * number - lines_offset
      end

      def lines_area
        @lines_area ||= width + 2 * lines_offset
      end

      def lines_offset
        @lines_offset ||= line_area.abs + line_step
      end

      def line_step
        @line_step ||= line_width + line_indentation
      end
    end
  end
end
