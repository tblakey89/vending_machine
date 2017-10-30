require_relative '../../vending_machine/change_loader'

RSpec.describe ChangeLoader do
  subject { ChangeLoader.new('') }
  let(:json_string) do
    "{\"change\":[{\"name\":\"#{coin}\",\"quantity\":#{coin_quantity}}]}"
  end
  let(:coin) { '20p' }
  let(:coin_quantity) { 10 }

  describe '#load' do
    context 'with valid file coin' do
      before { allow(File).to receive(:read).and_return(json_string) }

      context 'with valid json, correct format' do
        it 'should load correct change' do
          change = subject.load
          expect(change['change'].length).to eql(1)
          expect(change['change'].first['name']).to eql(coin)
          expect(change['change'].first['quantity']).to eql(coin_quantity)
        end
      end

      context 'with valid json, incorrect format' do
        let(:json_string) do
          "{{\"name\":\"#{coin}\",\"quantity\":#{coin_quantity}}}"
        end

        it 'should not load any change' do
          change = subject.load
          expect(change.length).to eql(0)
        end
      end

      context 'with invalid json' do
        let(:json_string) { 'dsfgrtgfew' }
        it 'should load no change and display to user' do
          expect(Display).to receive(:failed_change)
          expect(subject.load).to eql({})
        end
      end
    end

    context 'with invalid file name' do
      it 'should load no change and display to user' do
        expect(Display).to receive(:failed_change)
        expect(subject.load).to eql({})
      end
    end
  end
end
