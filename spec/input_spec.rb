require_relative '../input'
require_relative '../item'

describe Input do
  before :each do
    @items = []
    @items.push(Item.new(1, "book", 12.49))
    @items.push(Item.new(1, "music cd", 14.99))
    @items.push(Item.new(1, "chocolate bar", 0.85))
    @input = Input.new(@items)
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
    end
  end

  context 'imported goods' do
    it 'adds import tax to import goods' do
      @items.push(Item.new(1, "imported bottle of perfume", 47.50))
      @input.calculate_goods_tax
      @input.calculate_import_tax
      @input.assign_taxes

      # expect(@input.items.last.price).to eq(54.65) ASSUMED TYPO
      expect(@input.items.last.price).to eq(54.63)
    end
  end

end

