module Images
  module Backgrounds
    class CirclesGrid
      class << self
        SPECIFIC_OPTIONS = %i[circle_radius]
      end

      def initialize(chaos:, width:, height:, colors:, circle_radius: 15)
        @width = width
        @height = height
        @circle_radius = circle_radius.to_f

        @background = colors.sample(random: chaos)
        @color = colors.reject { |color| color == background }.sample(random: chaos)
      end

      def svg
        result = Victor::SVG.new
        result.rect x: 0, y: 0, width: width, height: height, fill: background

        lines_number_y.times do |step_y|
          y = offset_y + line_indentation_y * (step_y + 1) + 2 * circle_radius * step_y + circle_radius
          lines_number_x.times do |step_x|
            x = offset_x + line_indentation_x * (step_x + 1) + 2 * circle_radius * step_x + circle_radius

            result.circle cx: x, cy: y, fill: color, r: circle_radius
          end
        end

        result
      end

      private

      attr_reader :width, :height, :circle_radius, :background, :color

      def offset_x
        @offset_x ||= (width - line_indentation_x - (2 * circle_radius + line_indentation_x) * lines_number_x) / 2
      end

      def offset_y
        @offset_y ||= (height - line_indentation_y - (2 * circle_radius + line_indentation_y) * lines_number_y) / 2
      end

      def line_indentation_x
        @line_indentation_x ||= (width - 2.0 * circle_radius * lines_number_x) / (lines_number_x + 2)
      end

      def line_indentation_y
        @line_indentation_y ||= (height - 2.0 * circle_radius * lines_number_y) / (lines_number_y + 2)
      end

      def lines_number_x
        @lines_number_x ||= (width / (3 * circle_radius)).to_i
      end

      def lines_number_y
        @lines_number_y ||= (height / (3 * circle_radius)).to_i
      end
    end
  end
end
