require 'victor'
require 'mini_magick'

module Images
  class Draw
    class << self
      def png_file(seed:, width:, height:, emoji_size:, colors:, background:, options:, &block)
        file = svg_file(
          seed: seed,
          width: width,
          height: height,
          emoji_size: emoji_size,
          colors: colors,
          background: background,
          options: options
        )

        png_file_path = "./tmp/#{File.basename(file, File.extname(file))}.png"
        if File.exist?(png_file_path)
          block.call(png_file_path)
          return
        end

        `rsvg-convert #{file.path} > #{png_file_path}`
        block.call(png_file_path)

        # File.delete(file.path)
        # File.delete(png_file_path)
      end

      def svg_file(seed:, width:, height:, emoji_size:, colors:, background:, options:)
        filename = "./tmp/#{seed}.svg"
        if File.exist?(filename)
          file = File.open(filename, 'r')
          file.close
          return file
        end

        file = File.open(filename, 'w')
        file.write(
          svg(
            seed: seed,
            width: width,
            height: height,
            emoji_size: emoji_size,
            colors: colors,
            background: background,
            options: options
          )
        )
        file.close

        file
      end

      def svg(seed:, width:, height:, emoji_size:, colors:, background:, options:)
        chaos = Random.new seed

        svg = Victor::SVG.new width: "#{width}px", height: "#{height}px", viewbox: "0 0 #{width} #{height}"
        svg << background.new(chaos: chaos, width: width, height: height, colors: colors, **options).svg
        svg << gradient(width, height)
        svg << emoji(chaos, width, height, emoji_size)

        svg.render
      end

      private

      def emoji(chaos, width, height, emoji_size)
        svg = Victor::SVG.new
        svg.image(
          'xlink:href': EMOJIS.sample(random: chaos),
          x: x(width, emoji_size),
          y: y(height, emoji_size),
          width: emoji_size,
          height: emoji_size
        )

        svg
      end

      def gradient(width, height)
        svg = Victor::SVG.new
        svg.defs do
          svg.radialGradient id: :gradient do
            svg.stop offset: '0%', 'stop-color': :transparent, 'stop-opacity': 0
            svg.stop offset: '100%', 'stop-color': '#000', 'stop-opacity': 0.3
          end
        end

        svg.rect x: 0, y: 0, width: width, height: height, fill: 'url(#gradient)'
        svg
      end

      def x(width, emoji_size)
        (width - emoji_size) / 2
      end

      def y(height, emoji_size)
        (height - emoji_size) / 2
      end
    end
  end
end
