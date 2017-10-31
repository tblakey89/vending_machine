require_relative 'vending_machine/vending_machine'

VendingMachine.new.start
# Design a vending machine using ruby. The vending machine should perform as
# follows:
# Once an item is selected and the appropriate amount of money is inserted, the
# vending machine should return the correct product.
# It should also return change if too much money is provided, or ask for more
# money if insufficient funds have been inserted.
# The machine should take an initial load of products and change. The change
# will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, 1pound, 2pound.
# There should be a way of reloading either products or change at a later point.
# The machine should keep track of the products and change that it contains

# notes
# need to confirm json input is right format
# we should set price, code and name as a constant for each item, if item from json is not in our list, it is rejected with message
# change needs to work like stock and delivery_loader, inherit from loader object
# deliery loader and change loader should only accept valid json, and valid items/coin sizes
# money should also be kept in constants
# for giving change maybe some kind of recursive method that goes through each denomination, if able to give, it gives, then try same again
# if not, move to next smallest available, etc