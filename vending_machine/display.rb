# A class to display messages to user
class Display
  class << self
    def added_change
      puts 'Successfully added change'
    end

    def added_coin(coin)
      puts "Successfully added #{coin}"
    end

    def added_stock
      puts 'Successfully added stock'
    end

    def dispense_item(item)
      puts "Dispensing #{item[:name]}. Enjoy"
    end

    def failed_delivery
      puts 'The delivery failed.'
    end

    def failed_change
      puts 'The change was not able to be loaded.'
    end

    def get_change(amount, valid_coins)
      puts "You have #{in_pounds(amount)} left to pay.
            Please enter a coin (#{valid_coins.join(', ')}),
            or exit to return to options"
      gets.strip
    end

    def get_change_location
      puts 'Please enter a file name for the location of the change delivery.
            Or, enter \'exit\' to return to the options'
      gets.strip
    end

    def get_delivery_location
      puts 'Please enter a file name for the location of the stock delivery.
            Or, enter \'exit\' to return to the options'
      gets.strip
    end

    def get_item_code
      puts 'Please enter the code for the item you would like to purchase.
            Or enter \'exit\' to return to options.'
      gets.strip
    end

    def invalid_coin
      puts 'You have entered an invalid coin.'
    end

    def not_enough_change_available
      puts 'We are sorry, we do not have enough change available.
            We will return your money.'
    end

    def options
      puts 'Please enter \'buy\' to purchase from the vending machine.
            Please enter \'change\' to load change into the machine.
            Please enter \'stock\' to load stock into the machine.
            Please enter \'exit\' to leave the vending machine.'
      gets.strip
    end

    def out_of_stock(name)
      puts "#{name} is out of stock."
    end

    def return_change(change)
      puts "Returning coins: #{change.join(', ')}"
    end

    def stock_level(item)
      puts "#{item[:code]}: #{item[:name]} - #{item[:quantity]} available."
    end

    def success_change
      puts 'You have entered the right amount of change.'
    end

    def thank_you
      puts 'Thank you for using Thomas Blakey\'s vending machine'
    end

    def unknown_item_code
      puts 'You have entered an unknown item code.'
    end

    def unknown_option
      puts 'You have entered an unknown option.'
    end

    def welcome
      puts 'Welcome to Thomas Blakey\'s vending machine'
    end

    private

    def in_pounds(amount)
      pounds = amount / 100
      pence = amount % 100
      "£#{pounds}.#{pence}"
    end
  end
end
