require 'json'
require_relative 'display'

# class to load the json into an array
class Loader
  def initialize(location)
    @location = location
  end

  def load
    json = JSON.parse(File.read(location))
    validate_json(json)
  rescue Errno::ENOENT, JSON::ParserError
    invalid_load
  end

  private

  attr_reader :location

  def invalid_load
    Display.failed_delivery
    {}
  end

  def valid_delivery?(_)
    true
  end

  def validate_json(formatted_json)
    return invalid_load unless valid_delivery?(formatted_json)
    formatted_json
  end
end
