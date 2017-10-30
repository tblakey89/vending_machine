# A class to display messages to user
class Display
  class << self
    def added_stock
      puts 'Successfully added stock'
    end

    def failed_delivery
      puts 'The delivery failed.'
    end

    def failed_change
      puts 'The change was not able to be loaded.'
    end

    def out_of_stock(name)
      puts "#{name} is out of stock."
    end

    def stock_level(item)
      puts "#{item[:code]}: #{item[:name]} - #{item[:quantity]} available."
    end
  end
end
