require 'yaml'

module CallbackData
  ACTION_NAME_SEPARATOR = '-'.freeze
  PARAMS_SEPARATOR = ':'.freeze
  INTEGER_IDENTIFIER = '0'.freeze
  INTEGER_RADIX = 36

  COMPRESSION_TABLE_FILE = File.expand_path('compression_table.yml', __dir__)
  COMPRESSION_TABLE = YAML.load_file(COMPRESSION_TABLE_FILE)

  module_function

  def compile(name, **options)
    string_options = options.compact.map do |key, value|
      compressed_value = value.is_a?(Integer) ? compress_int(value) : compress(value.to_s)
      "#{compress(key.to_s)}#{PARAMS_SEPARATOR}#{compressed_value}"
    end

    params = string_options.join(PARAMS_SEPARATOR) if !string_options.empty?
    [compress(name), params].compact.join(ACTION_NAME_SEPARATOR)
  end

  def decompile(action)
    action_name, raw_options = action.split(ACTION_NAME_SEPARATOR)
    return [decompress(action_name), {}] unless raw_options

    decompressed_options = raw_options.split(PARAMS_SEPARATOR).map do |option|
      next decompress_int(option) if option[0] == INTEGER_IDENTIFIER

      decompress(option)
    end
    options = Hash[*decompressed_options]
    [decompress(action_name), options.transform_keys { |key| key.to_sym }]
  end

  def compress(string)
    COMPRESSION_TABLE[string] || string
  end

  def decompress(string)
    COMPRESSION_TABLE.key(string) || string
  end

  def compress_int(number)
    "#{INTEGER_IDENTIFIER}#{number.to_s(INTEGER_RADIX)}"
  end

  def decompress_int(number)
    number.to_i(INTEGER_RADIX)
  end
end
