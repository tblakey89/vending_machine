require_relative '../../vending_machine/change'

RSpec.describe Change do
  subject { Change.new(initial_change) }
  let(:initial_change) { [{ 'name' => coin_name, 'quantity' => 5 }] }
  let(:coin_name) { '20p' }
  let(:coin_amount) { 20 }
  before do
    stub_const('Change::COIN_INFORMATION', coin_name => coin_amount)
  end

  describe '#new' do
    context 'no initial change' do
      let(:initial_change) { {} }
      it 'should set up change' do
        change = subject.change
        expect(change.length).to eql(1)
        expect(change[coin_amount]).to eql(0)
      end
    end

    context 'with initial change' do
      it 'should set up change' do
        change = subject.change
        expect(change.length).to eql(1)
        expect(change[coin_amount]).to eql(5)
      end
    end
  end

  describe '#able_to_provide_change?' do
    context 'when not enough change available' do
      it 'returns false' do
        expect(subject.able_to_provide_change?(300)).to be false
      end
    end

    context 'when enough change available' do
      describe 'just 20p' do
        it 'returns true' do
          expect(subject.able_to_provide_change?(100)).to be true
        end
      end

      describe 'different coin types' do
        let(:initial_change) do
          [
            { 'name' => coin_name, 'quantity' => 5 },
            { 'name' => '1p', 'quantity' => 100 }
          ]
        end
        before do
          stub_const('Change::COIN_INFORMATION', coin_name => coin_amount,
                                                 '1p' => 1)
        end
        it 'returns true' do
          expect(subject.able_to_provide_change?(98)).to be true
        end
      end
    end

    context 'when enough change, but not exact' do
      it 'returns false' do
        expect(subject.able_to_provide_change?(98)).to be false
      end
    end
  end

  describe '#add_change' do
    let(:new_change) { [{ 'name' => coin_name, 'quantity' => 30 }] }
    it 'increases quantity of available coins' do
      subject
      expect(Display).to receive(:added_change)
      subject.add_change(new_change)
      expect(subject.change[coin_amount]).to eql(35)
    end
  end

  describe '#give_change' do
    context 'when enough change available' do
      it 'removes the change from the change class and returns an array of
          strings' do
        string = subject.give_change(100)
        expect(subject.change[coin_amount]).to eql(0)
        expect(string).to eql(Array.new(5, coin_name))
      end
    end
  end
end
