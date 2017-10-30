require_relative 'item_information_helper'

# helper module to validate the item hash
module ValidationHelper
  def check_valid?(item, allowed_names)
    item.is_a?(Hash) &&
      name_valid?(item, allowed_names) &&
      quantity_valid?(item)
  end

  def name_valid?(item, allowed_names)
    item.key?('name') &&
      item['name'].is_a?(String) &&
      allowed_names.include?(item['name'])
  end

  def quantity_valid?(item)
    item.key?('quantity') &&
      item['quantity'].is_a?(Integer)
  end
end
