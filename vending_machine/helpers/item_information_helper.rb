# a class to contain information on items
module ItemInformationHelper
  COCA_COLA = 'Coca Cola'.freeze
  FANTA = 'Fanta'.freeze
  SPRITE = 'Sprite'.freeze
  OASIS = 'Oasis'.freeze
  WATER = 'Water'.freeze

  ALLOWED_ITEMS = [
    COCA_COLA,
    FANTA,
    SPRITE,
    OASIS,
    WATER
  ].freeze

  PRODUCT_INFORMATION = {
    COCA_COLA => { price: 60, code: '100' },
    FANTA => { price: 65, code: '101' },
    SPRITE => { price: 70, code: '102' },
    OASIS => { price: 100, code: '103' },
    WATER => { price: 200, code: '104' }
  }.freeze
end
