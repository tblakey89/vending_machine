require_relative 'display'
require_relative 'helpers/item_information_helper'

# A class to hold stock information for the vending machine
class Stock
  include ItemInformationHelper

  def initialize(intial_stock)
    @items = set_up_item_hash
    add_items(intial_stock)
  end

  attr_reader :items

  def add_items(new_items)
    return if new_items['items'].nil?
    new_items['items'].each do |new_item|
      items[new_item['name']][:quantity] += new_item['quantity']
    end
    Display.added_stock
  end

  def available?(item_code)
    item = find_item(item_code)
    !item.nil? && item[:quantity] > 0
  end

  def item_details(item_code)
    find_item(item_code)
  end

  def list
    items.each_value do |item|
      if item[:quantity] > 0
        Display.stock_level(item)
      else
        Display.out_of_stock(item[:name])
      end
    end
  end

  def remove(item_code)
    item = find_item(item_code)
    item[:quantity] -= 1 if !item.nil? && item[:quantity] > 0
  end

  private

  def find_item(item_code)
    items.values.find { |stock_item| stock_item[:code] == item_code }
  end

  def set_up_item_hash
    PRODUCT_INFORMATION.each_with_object({}) do |(key, value), by_name|
      by_name[key] = { name: key,
                       code: value[:code],
                       price: value[:price],
                       quantity: 0 }
    end
  end
end
