require_relative 'loader'
require_relative 'helpers/validation_helper'
require_relative 'helpers/change_information_helper'

# class to load the json change into an array
class ChangeLoader < Loader
  include ValidationHelper
  include ChangeInformationHelper

  private

  def invalid_load
    Display.failed_change
    {}
  end

  def valid_delivery?(formatted_json)
    formatted_json.key?('change') && formatted_json['change'].is_a?(Array) &&
      formatted_json['change'].all? do |item|
        check_valid?(item, ALLOWED_CHANGE)
      end
  end
end
