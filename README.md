# Vending Machine

Design a vending machine using ruby. The vending machine should perform as follows:
Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product.
It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted.
The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
There should be a way of reloading either products or change at a later point.
The machine should keep track of the products and change that it contains.

## How To Use

```
ruby main.rb
```
Once on the application, follow the instructions to use the vending machine

### Delivering change or stock

At vending_machine/deliveries there is a number of json files to refill the change or stock. Select the 'change' or 'stock' option, then enter the filename as follows:

```
Please enter a file name for the location of the stock delivery.
Or, enter 'exit' to return to the options
vending_machine/deliveries/second_delivery.json
```