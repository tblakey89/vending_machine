require_relative 'display'
require_relative 'helpers/change_information_helper'

# A class to hold change for the vending machine
class Change
  include ChangeInformationHelper

  def initialize(intial_change)
    @change = set_up_change
    add_change(intial_change)
  end

  attr_reader :change

  def able_to_provide_change?(to_be_given)
    # need to provide exact change, simply reducing our change
    # hash for sum of coins won't do, 2 50p can't provide for 75p
    to_be_used = coins_to_be_used(to_be_given,
                                  change.dup,
                                  COIN_INFORMATION.values.reverse,
                                  [])
    to_be_used.reduce(0, :+) == to_be_given
  end

  def add_change(new_coins)
    return if new_coins['change'].nil?
    new_coins['change'].each do |coin|
      change[string_to_amount(coin['name'])] += coin['quantity']
    end
    Display.added_change
  end

  def add_coin(amount)
    change[amount] += 1
  end

  def give_change(to_be_given)
    to_be_used = coins_to_be_used(to_be_given,
                                  change.dup,
                                  COIN_INFORMATION.values.reverse,
                                  [])
    remove_change(to_be_used)
    to_be_used.map { |amount| amount_to_string(amount) }
  end

  private

  def amount_to_string(amount)
    COIN_INFORMATION.invert[amount]
  end

  def coins_to_be_used(amount_required, available, coins, to_be_used)
    # this could be put into a service class to refactor it
    return to_be_used if coins.length.zero?
    value = coins.first
    if equal_and_available?(amount_required, available, value)
      to_be_used << value
    elsif less_than_and_available?(amount_required, available, value)
      amount_required -= value
      available[value] -= 1
      to_be_used << value
      coins_to_be_used(amount_required, available, coins, to_be_used)
    elsif greater_than_required_and_coins?(amount_required, coins, value) ||
          less_than_and_not_available?(amount_required, available, value)
      coins_to_be_used(amount_required, available, coins.drop(1), to_be_used)
    else
      to_be_used
    end
  end

  def equal_and_available?(amount_required, available, value)
    value == amount_required && available[value] > 0
  end

  def greater_than_required_and_coins?(amount_required, coins, value)
    value > amount_required && coins.length > 1
  end

  def less_than_and_available?(amount_required, available, value)
    value < amount_required && available[value] > 0
  end

  def less_than_and_not_available?(amount_required, available, value)
    value < amount_required && available[value].zero?
  end

  def remove_change(coins)
    coins.each { |coin| change[coin] -= 1 }
  end

  def set_up_change
    COIN_INFORMATION.each_with_object({}) do |(_, value), by_amount|
      by_amount[value] = 0
    end
  end

  def string_to_amount(string)
    COIN_INFORMATION[string]
  end
end
