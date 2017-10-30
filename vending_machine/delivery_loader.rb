require_relative 'loader'
require_relative 'helpers/validation_helper'
require_relative 'helpers/item_information_helper'

# class to load the json deliveries into an array
class DeliveryLoader < Loader
  include ValidationHelper
  include ItemInformationHelper

  private

  def invalid_load
    Display.failed_delivery
    {}
  end

  def valid_delivery?(formatted_json)
    formatted_json.key?('items') && formatted_json['items'].is_a?(Array) &&
      formatted_json['items'].all? { |item| check_valid?(item, ALLOWED_ITEMS) }
  end
end
