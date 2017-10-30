require_relative '../../vending_machine/stock'

RSpec.describe Stock do
  subject { Stock.new(initial_stock) }
  let(:item_name) { 'Coca Cola' }
  let(:item_code) { '201' }
  let(:initial_stock) { [{ 'name' => item_name, 'quantity' => 5 }] }
  before do
    stub_const('Stock::PRODUCT_INFORMATION',
               item_name => { code: item_code, price: 50 })
  end

  describe '#new' do
    context 'no initial stock' do
      let(:initial_stock) { {} }
      it 'should set up items' do
        stock = subject.items
        expect(stock.length).to eql(1)
        expect(stock[item_name][:quantity]).to eql(0)
      end
    end

    context 'with initial stock' do
      it 'should set up items' do
        stock = subject.items
        expect(stock.length).to eql(1)
        expect(stock[item_name][:quantity]).to eql(5)
      end
    end
  end

  describe '#add_items' do
    let(:new_stock) { [{ 'name' => item_name, 'quantity' => 10 }] }
    it 'increases quantity of available items' do
      subject
      expect(Display).to receive(:added_stock)
      subject.add_items(new_stock)
      expect(subject.items[item_name][:quantity]).to eql(15)
    end
  end

  describe '#available?' do
    context 'with correct code' do
      it 'finds item, and checks availability' do
        expect(subject.available?(item_code)).to be true
      end
    end

    context 'with incorrect code' do
      it 'finds item, and checks availability' do
        expect(subject.available?('401')).to be false
      end
    end
  end

  describe '#list' do
    context 'when item is in stock' do
      it 'shows stock level of items' do
        expect(Display).to receive(:stock_level)
        subject.list
      end
    end

    context 'when item is not in stock' do
      let(:initial_stock) { [{ 'name' => item_name, 'quantity' => 0 }] }
      it 'shows out of stock message for item' do
        expect(Display).to receive(:out_of_stock)
        subject.list
      end
    end
  end

  describe '#remove' do
    it 'reduces the stock by one' do
      subject.remove(item_code)
      expect(subject.items[item_name][:quantity]).to eql(4)
    end
  end
end
