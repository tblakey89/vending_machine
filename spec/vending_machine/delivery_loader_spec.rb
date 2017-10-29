require_relative '../../vending_machine/delivery_loader'

RSpec.describe DeliveryLoader do
  subject { DeliveryLoader.new('') }
  let(:json_string) do
    "{\"items\":[{\"name\":\"#{item_name}\",\"quantity\":10}]}"
  end
  let(:item_name) { 'coca cola' }
  let(:item_quantity) { 10 }

  describe '#load' do
    context 'with valid file name' do
      before { allow(File).to receive(:read).and_return(json_string) }

      it 'should load correct items' do
        items = subject.load
        expect(items['items'].length).to eql(1)
        expect(items['items'].first['name']).to eql(item_name)
        expect(items['items'].first['quantity']).to eql(item_quantity)
      end
    end

    context 'with invalid file name' do
      it 'should load no items' do
        expect(subject.load).to eql({})
      end

      it 'should print a warning message' do
        expect { subject.load }.to output.to_stdout
      end
    end

    context 'with invalud json string in file' do
      let(:json_string) { 'dsfgrtgfew' }
      it 'should load no items' do
        expect(subject.load).to eql({})
      end

      it 'should print a warning message' do
        expect { subject.load }.to output.to_stdout
      end
    end
  end
end
