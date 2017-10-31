require_relative 'stock'
require_relative 'change'
require_relative 'delivery_loader'
require_relative 'change_loader'
require_relative 'change_collector'

# class to represent vending machine
class VendingMachine
  def initialize
    @stock = Stock.new(load_delivery(FIRST_DELIVERY))
    @change = Change.new(load_change(FIRST_CHANGE))
  end

  def start
    Display.welcome
    loop do
      case Display.options
      when DELIVER_STOCK
        deliver_stock
      when DELIVER_CHANGE
        deliver_change
      when BUY
        buy_item
      when EXIT
        Display.thank_you
        break
      else
        Display.unknown_option
      end
    end
  end

  private

  attr_reader :stock, :change

  BUY = 'buy'.freeze
  DELIVER_CHANGE = 'change'.freeze
  DELIVER_STOCK = 'stock'.freeze
  EXIT = 'exit'.freeze
  FIRST_CHANGE = 'vending_machine/deliveries/first_change.json'.freeze
  FIRST_DELIVERY = 'vending_machine/deliveries/first_delivery.json'.freeze

  def buy_item
    stock.list
    item_code = Display.get_item_code
    return if item_code == EXIT
    if stock.available?(item_code)
      enter_change(stock.item_details(item_code))
    else
      Display.unknown_item_code
    end
  end

  def deliver_change
    location = Display.get_change_location
    return if location == EXIT
    change.add_change(load_change(location))
  end

  def deliver_stock
    location = Display.get_delivery_location
    return if location == EXIT
    stock.add_items(load_delivery(location))
  end

  def enter_change(item)
    return unless ChangeCollector.new(item[:price], change).run
    Display.dispense_item(item)
    stock.remove(item[:code])
  end

  def load_change(location)
    ChangeLoader.new(location).load
  end

  def load_delivery(location)
    DeliveryLoader.new(location).load
  end
end
