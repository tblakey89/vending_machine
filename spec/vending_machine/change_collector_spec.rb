require_relative '../../vending_machine/change_collector'
require_relative '../../vending_machine/change'

RSpec.describe ChangeCollector do
  subject { ChangeCollector.new(amount_required, change) }
  let(:change) { Change.new(initial_change) }
  let(:amount_required) { 100 }
  let(:initial_change) do
    { 'change' => [
      { 'name' => coin_name, 'quantity' => 5 },
      { 'name' => coin_name2, 'quantity' => 5 }
    ] }
  end
  let(:coin_name) { '20p' }
  let(:coin_name2) { '10p' }

  before do
    allow(Display).to receive(:get_change).and_return(coin_name)
  end

  describe '#run' do
    context 'enter enough change' do
      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).exactly(5).times
        expect(Display).to receive(:added_coin).exactly(5).times
        expect(Display).to receive(:return_change).exactly(0).times
        expect(Display).to receive(:invalid_coin).exactly(0).times
        expect(subject.run).to be true
      end
    end

    context 'too much change is entered' do
      let(:amount_required) { 90 }
      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).exactly(5).times
        expect(Display).to receive(:added_coin).exactly(5).times
        expect(Display).to receive(:return_change).once
        expect(Display).to_not receive(:invalid_coin).exactly(0).times
        expect(subject.run).to be true
      end
    end

    context 'unable to provide change' do
      let(:amount_required) { 90 }
      let(:initial_change) do
        { 'change' => [{ 'name' => coin_name, 'quantity' => 5 }] }
      end
      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).exactly(5).times
        expect(Display).to receive(:added_coin).exactly(5).times
        expect(Display).to receive(:not_enough_change_available).once
        expect(Display).to receive(:return_change).once
        expect(Display).to receive(:invalid_coin).exactly(0).times
        expect(subject.run).to be false
      end
    end

    context 'exits when requested' do
      before do
        allow(Display).to receive(:get_change).and_return('exit')
      end

      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).once
        expect(Display).to receive(:added_coin).exactly(0).times
        expect(Display).to receive(:return_change).once
        expect(Display).to receive(:invalid_coin).exactly(0).times
        expect(subject.run).to be false
      end
    end

    context 'when enters invalid coin and exits' do
      before do
        allow(Display).to receive(:get_change).and_return('10c', 'exit')
      end

      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).exactly(2).times
        expect(Display).to receive(:added_coin).exactly(0).times
        expect(Display).to receive(:return_change).once
        expect(Display).to receive(:invalid_coin).once
        expect(subject.run).to be false
      end
    end

    context 'when enters coins, then gives up' do
      before do
        allow(Display).to receive(:get_change).and_return(coin_name,
                                                          coin_name,
                                                          coin_name,
                                                          'exit')
      end

      it 'returns true and displays correct messages' do
        expect(Display).to receive(:get_change).exactly(4).times
        expect(Display).to receive(:added_coin).exactly(3).times
        expect(Display).to receive(:return_change).once
        expect(Display).to receive(:invalid_coin).exactly(0).times
        expect(subject.run).to be false
      end
    end
  end
end
