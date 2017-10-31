require_relative '../../vending_machine/vending_machine'

RSpec.describe VendingMachine do
  subject { VendingMachine.new }
  let(:option) { 'exit' }
  let(:item_name) { 'Coca Cola' }
  let(:item_code) { '201' }

  before do
    allow(Display).to receive(:options).and_return(option)
    allow(Display).to receive(:get_item_code).and_return(item_code)
    allow_any_instance_of(ChangeCollector).to receive(:run).and_return(true)
    stub_const('Stock::PRODUCT_INFORMATION',
               item_name => { code: item_code, price: 50 })
    stub_const('VendingMachine::FIRST_DELIVERY',
               'spec/vending_machine/deliveries/test_item_delivery.json')
    stub_const('VendingMachine::FIRST_CHANGE',
               'spec/vending_machine/deliveries/test_change_delivery.json')
  end

  describe '#start' do
    context 'basic run through' do
      it 'displays the basic options, then exits' do
        expect(Display).to receive(:welcome).once
        expect(Display).to receive(:thank_you).once
        expect(Display).to receive(:dispense_item).exactly(0).times
        expect(Display).to receive(:get_change_location).exactly(0).times
        expect(Display).to receive(:get_delivery_location).exactly(0).times
        subject.start
      end
    end

    context 'buy two items' do
      before do
        allow(Display).to receive(:options).and_return('buy', 'buy', 'exit')
      end
      it 'dispenses two items, then exits' do
        expect(Display).to receive(:welcome).once
        expect(Display).to receive(:thank_you).once
        expect(Display).to receive(:dispense_item).exactly(2).times
        expect(Display).to receive(:get_change_location).exactly(0).times
        expect(Display).to receive(:get_delivery_location).exactly(0).times
        subject.start
      end
    end

    context 'buy till out of stock' do
      before do
        allow(Display).to receive(:options).and_return('buy', 'buy', 'buy',
                                                       'buy', 'exit')
      end
      it 'dispenses three items, one fail, then exits' do
        expect(Display).to receive(:welcome).once
        expect(Display).to receive(:thank_you).once
        expect(Display).to receive(:dispense_item).exactly(3).times
        expect(Display).to receive(:unknown_item_code).once
        expect(Display).to receive(:get_change_location).exactly(0).times
        expect(Display).to receive(:get_delivery_location).exactly(0).times
        subject.start
      end
    end

    context 'load stock' do
      before do
        allow(Display).to receive(:options).and_return('stock', 'exit')
        allow(Display).to receive(:get_delivery_location)
          .and_return('spec/vending_machine/deliveries/test_item_delivery.json')
      end
      it 'loads stock successfully' do
        expect(Display).to receive(:welcome).once
        expect(Display).to receive(:thank_you).once
        expect(Display).to receive(:dispense_item).exactly(0).times
        expect(Display).to receive(:unknown_item_code).exactly(0).times
        expect(Display).to receive(:get_change_location).exactly(0).times
        expect(Display).to receive(:get_delivery_location).once
        subject.start
      end
    end

    context 'load change' do
      before do
        allow(Display).to receive(:options).and_return('change', 'exit')
        allow(Display).to receive(:get_change_location)
          .and_return(
            'spec/vending_machine/deliveries/test_change_delivery.json'
          )
      end
      it 'loads stock successfully' do
        expect(Display).to receive(:welcome).once
        expect(Display).to receive(:thank_you).once
        expect(Display).to receive(:dispense_item).exactly(0).times
        expect(Display).to receive(:unknown_item_code).exactly(0).times
        expect(Display).to receive(:get_change_location).once
        expect(Display).to receive(:get_delivery_location).exactly(0).times
        subject.start
      end
    end
  end
end
