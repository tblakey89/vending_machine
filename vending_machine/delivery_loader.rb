require 'json'

# class to load (parse) the json deliveries into an array
class DeliveryLoader
  def initialize(location)
    @location = location
  end

  def load
    JSON.parse(File.read(location))
  rescue Errno::ENOENT, JSON::ParserError
    invalid_delivery
  end

  private

  attr_reader :location

  def invalid_delivery
    puts 'The delivery failed'
    {}
  end
end
