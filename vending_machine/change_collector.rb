require_relative 'display'
require_relative 'helpers/change_information_helper'

# A class to collect change from the user
class ChangeCollector
  include ChangeInformationHelper

  def initialize(amount_required, change)
    @change = change
    @amount_required = amount_required
    @change_entered = 0
  end

  def run
    loop do
      coin = Display.get_change(amount_required - change_entered,
                                ALLOWED_CHANGE)
      return exit_change if coin == EXIT
      add_coin(coin)
      return unable_to_provide_change if change_not_available?
      break if change_entered >= amount_required
    end
    return_change
    true
  end

  private

  attr_reader :change, :amount_required, :change_entered

  EXIT = 'exit'.freeze

  def add_coin(coin)
    if valid_coin?(coin)
      amount = coin_amount(coin)
      @change_entered += amount
      change.add_coin(amount)
      Display.added_coin(coin)
    else
      Display.invalid_coin
    end
  end

  def change_not_available?
    to_be_given = change_entered - amount_required
    return false if to_be_given < 0
    !change.able_to_provide_change?(to_be_given)
  end

  def coin_amount(coin)
    COIN_INFORMATION[coin]
  end

  def exit_change
    Display.return_change(change.give_change(change_entered))
    false
  end

  def return_change
    return unless change_entered > amount_required
    to_be_given = change_entered - amount_required
    Display.return_change(change.give_change(to_be_given))
  end

  def unable_to_provide_change
    Display.not_enough_change_available
    exit_change
  end

  def valid_coin?(coin)
    ALLOWED_CHANGE.include?(coin)
  end
end
