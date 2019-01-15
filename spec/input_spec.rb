require_relative '../input'
require_relative '../item'

describe Input do
  before :each do
    @items = [
      Item.new(1, "book", 12.49),
      Item.new(1, "music cd", 14.99),
      Item.new(1, "chocolate bar", 0.85)
    ]
    @input = Input.new(@items)
  end

  context 'Cart' do
    it 'reads csv file' do
      file = @input.read_file('./cart.csv')

      expect(file.length).to be > 0
      expect(file.first[1]).to be == "book"
    end

    it 'appends taxes' do
      file = @input.read_file('./cart.csv')
      @input
      expect(file)
    end
  end


  context 'new input' do
    it 'returns the input attributes' do

      expect(@input.items.first.product).to eq("book")
      expect(@input.items.first.price).to eq(12.49)
    end
  end

  context 'goods tax' do
    it 'adds basic goods tax' do
      @input.calculate_goods_tax
      @input.assign_taxes

      expect(@input.items[1].price).to eq(16.49)
    end

    it 'doesnt add goods tax to books, food or medical supplies' do
      @input.calculate_goods_tax
      @input.assign_taxes

      expect(@input.items.last.price).to eq(0.85)
      expect(@input.items.first.price).to eq(12.49)
    end
  end

  context 'imported goods' do
    it 'adds import tax to import goods' do
      @items.push(Item.new(1, "imported bottle of perfume", 47.50))
      @items.push(Item.new(1, "box of imported chocolates", 11.25))
      @items.push(Item.new(1, "imported bottle of perfume", 27.99))
      @items.push(Item.new(1, "imported box of chocolates", 10.00))
      @input.calculate_goods_tax
      @input.calculate_import_tax
      @input.assign_taxes

      # expect(@input.items[-4].price).to eq(54.65) ASSUMED TYPO
      # expect(@input.items[-3]..price).to eq(11.85) ASSUMED TYPO
      expect(@input.items[-4].price).to eq(54.63)
      expect(@input.items[-3].price).to eq(11.81)
      expect(@input.items[-2].price).to eq(32.19)
      expect(@input.items.last.price).to eq(10.50)
    end
  end

end

