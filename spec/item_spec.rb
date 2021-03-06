require_relative '../item'

RSpec.describe Item do
  subject { described_class.new(1, "book", 12.49) }

  describe 'new item' do
    it 'returns the items attributes' do

      expect(subject.quantity).to eq(1)
      expect(subject.product).to eq("book")
      expect(subject.price).to eq(12.49)
    end
  end
end

# input(Quantity: 1,Product: "book",Price: 12.49)
# input.basic_tax(input.price)

# Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

# When I purchase items I receive a receipt that lists the name of all the items and their price (including tax), finishing with the total cost of the items, and the total amounts of sales taxes paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

# Write an application that prints out the receipt details for these shopping baskets; this application should be written in Ruby [1] and use Rspec [2] to test inputs and the expected outputs. The output should be to standard out or CSV.

# Proper object orientated design is important. Each row in the input represents a line item of the receipt.

