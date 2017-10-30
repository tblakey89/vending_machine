require_relative '../../vending_machine/delivery_loader'

RSpec.describe DeliveryLoader do
  subject { DeliveryLoader.new('') }
  let(:json_string) do
    "{\"items\":[{\"name\":\"#{item_name}\",\"quantity\":#{item_quantity}}]}"
  end
  let(:item_name) { 'Coca Cola' }
  let(:item_quantity) { 10 }

  describe '#load' do
    context 'with valid file name' do
      before { allow(File).to receive(:read).and_return(json_string) }

      context 'with valid json, correct format' do
        it 'should load correct items' do
          items = subject.load
          expect(items['items'].length).to eql(1)
          expect(items['items'].first['name']).to eql(item_name)
          expect(items['items'].first['quantity']).to eql(item_quantity)
        end
      end

      context 'with valid json, incorrect format' do
        let(:json_string) do
          "{{\"name\":\"#{item_name}\",\"quantity\":#{item_quantity}}}"
        end

        it 'should not load any items' do
          items = subject.load
          expect(items.length).to eql(0)
        end
      end

      context 'with invalid json' do
        let(:json_string) { 'dsfgrtgfew' }
        it 'should load no items and display to user' do
          expect(Display).to receive(:failed_delivery)
          expect(subject.load).to eql({})
        end
      end
    end

    context 'with invalid file name' do
      it 'should load no items and display to user' do
        expect(Display).to receive(:failed_delivery)
        expect(subject.load).to eql({})
      end
    end
  end
end
