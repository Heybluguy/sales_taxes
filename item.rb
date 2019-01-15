require './spec/spec_helper'

class Item
  attr_reader :product
  attr_accessor :price, :quantity, :tax

  def initialize(quantity, product, price)
    @quantity = quantity
    @product = product
    @price = price
    @tax = 0
  end

end
