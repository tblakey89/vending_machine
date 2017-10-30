require_relative '../../../vending_machine/helpers/validation_helper'

RSpec.describe ValidationHelper do
  include ValidationHelper

  let(:valid_hash) do
    {
      'name' => item_name,
      'quantity' => item_quantity
    }
  end
  let(:invalid_hash) do
    {
      'nam' => item_name,
      'quantiy' => item_quantity
    }
  end
  let(:item_name) { 'Coca Cola' }
  let(:item_quantity) { 10 }
  let(:allowed_names) { [item_name] }

  describe '#check_valid?' do
    context 'valid hash' do
      it 'returns true' do
        expect(check_valid?(valid_hash, allowed_names)).to be true
      end
    end

    context 'invalid hash' do
      it 'returns false' do
        expect(check_valid?(invalid_hash, allowed_names)).to be false
      end
    end
  end

  describe '#name_valid?' do
    context 'with valid name' do
      it 'returns true' do
        expect(name_valid?(valid_hash, allowed_names)).to be true
      end
    end

    context 'with invalid name' do
      context 'with no name key' do
        it 'returns false' do
          expect(name_valid?(invalid_hash, allowed_names)).to be false
        end
      end

      context 'with invalid name' do
        let(:item_name) { 100 }
        it 'returns false' do
          expect(name_valid?(valid_hash, allowed_names)).to be false
        end
      end
    end

    describe '#quantity_valid?' do
      context 'with valid quantity' do
        it 'returns true' do
          expect(quantity_valid?(valid_hash)).to be true
        end
      end

      context 'with invalid quantity' do
        context 'with no quantity key' do
          it 'returns false' do
            expect(quantity_valid?(invalid_hash)).to be false
          end
        end

        context 'with invalid quantity' do
          let(:item_quantity) { 'Coca Cola' }
          it 'returns false' do
            expect(quantity_valid?(valid_hash)).to be false
          end
        end
      end
    end
  end
end
