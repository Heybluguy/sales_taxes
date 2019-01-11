require './spec/spec_helper'

class Input
  attr_reader :items

  def initialize(items)
    @items = items
    @goods = 10
    @import = 5
    @input_tax = 0.to_f.round(2)
    @exempt = [
      "book",
      "chocolate bar",
      "imported box of chocolates",
      "packet of headache pills",
      "box of imported chocolates"
    ]

    @imported = [
      "imported box of chocolates",
      "imported bottle of perfume",
      "imported bottle of perfume",
      "box of imported chocolates"
    ]
  end

  def calculate_goods_tax
    items.each do |item|
      if @exempt.select{|x| x.match(item.product)}.length < 1
        item_price = item.price * item.quantity
        item.tax += (@goods * item_price/100)
      end
    end
  end

  def calculate_import_tax
    items.each do |item|
      if @imported.select{|x| x.match(item.product)}.length > 0
        item_price = item.price * item.quantity
        item.tax += @import * item_price/100
      end
    end
  end

  def assign_taxes
    items.map do |item|
      item.price = (item.price + item.tax).to_f.round(2)
      @input_tax += item.tax
    end
  end

end