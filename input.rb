require './spec/spec_helper'
require 'csv'

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

  def read_file(filename)
    cart = []
    csv_contents = CSV.read(filename)
    csv_contents.shift
    csv_contents.each do |row|
      row.each do |detail|
        detail.strip!
      end
      cart << row
    end
    cart
  end

  def convert_to_item(file)
    items = []
    file.map do |row|
      items << Item.new(row[0].to_i, row[1], row[2].to_i)
    end
    items
  end

end

#   sums = CSV.readlines(in_file_path).map do |num1, num2|
#   num1.to_i + num2.to_i
# end

# # Write the result to a file
# CSV.open(out_file_path, "wb") do |csv|
#   sums.each { |sum| csv << [sum] }
# end

  # def populate(filename)
  #   CSV.foreach(filename, headers: true,header_converters: :symbol) do |row|
  #     @all << Item.new(row, self)
  #   end
  # end



