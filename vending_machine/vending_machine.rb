# class to represent vending machine
class VendingMachine
  def initialise
    @items = load_delivery(FIRST_DELIVERY)
  end

  private

  attr_reader :items

  FIRST_DELIVERY = 'first_delivery.json'.freeze

  def load_delivery(location)
    DeliveryLoader.new(location).load
  end
end
