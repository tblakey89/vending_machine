# a class to contain information on change
module ChangeInformationHelper
  ONE_PENCE = '1p'.freeze
  TWO_PENCE = '2p'.freeze
  FIVE_PENCE = '5p'.freeze
  TEN_PENCE = '10p'.freeze
  TWENTY_PENCE = '20p'.freeze
  FIFTY_PENCE = '50p'.freeze
  ONE_POUND = '£1'.freeze
  TWO_POUND = '£2'.freeze

  ALLOWED_CHANGE = [
    ONE_PENCE,
    TWO_PENCE,
    FIVE_PENCE,
    TEN_PENCE,
    TWENTY_PENCE,
    FIFTY_PENCE,
    ONE_POUND,
    TWO_POUND
  ].freeze

  COIN_INFORMATION = {
    ONE_PENCE => 1,
    TWO_PENCE => 2,
    FIVE_PENCE => 5,
    TEN_PENCE => 10,
    TWENTY_PENCE => 20,
    FIFTY_PENCE => 50,
    ONE_POUND => 100,
    TWO_POUND => 200
  }.freeze
end
