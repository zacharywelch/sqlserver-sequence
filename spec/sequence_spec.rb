require 'spec_helper'

class Supplier < ActiveRecord::Base; end

describe Sqlserver::Sequence do
  
  after(:each) { Supplier.sequences = {} }
  
  describe '.sequences' do

    context 'single sequence' do

      before do
        Supplier.sequence :number, name: 'sequence', prefix: 'N'
      end

      let(:expected) do
        {
          number: {
            name: 'sequence',
            prefix: 'N',
            format: nil
          }
        }
      end

      specify { expect(Supplier.sequences).to eq(expected) }
    end

    context 'multiple sequences' do

      before do
        Supplier.sequence :number1, name: 'sequence1', prefix: 'N'
        Supplier.sequence :number2, name: 'sequence2', prefix: 'N'
      end

      let(:expected) do
        {
          number1: {
            name: 'sequence1',
            prefix: 'N',
            format: nil
          },
          number2: {
            name: 'sequence2',
            prefix: 'N',
            format: nil
          }
        }
      end

      specify { expect(Supplier.sequences).to eq(expected) }
    end

    context 'with defaults' do

      before do
        Supplier.sequence :number
      end

      let(:expected) do
        {
          number: {
            name: 'number',
            prefix: nil,
            format: nil
          }
        }
      end

      specify { expect(Supplier.sequences).to eq(expected) }
    end
  end

  describe '#next_sequence_number' do

    before do
      Supplier.sequence :number
    end

    let!(:supplier) { Supplier.create }
    let!(:other_supplier) { Supplier.create }

    it 'returns the next value' do
      expect(other_supplier.number).to be > supplier.number
    end
  end

  describe 'saving' do

    before do 
      allow_any_instance_of(Supplier).to receive(:next_sequence_value).
                                      with('sequence').
                                      and_return('1234567')
    end

    subject(:supplier) { Supplier.create }

    context 'without options' do
      before do
        Supplier.sequence :number, name: 'sequence'
      end
      specify { expect(supplier.number).to eq '1234567' }
    end

    context 'with prefix' do
      before do
        Supplier.sequence :number, name: 'sequence', prefix: 'N'
      end
      specify { expect(supplier.number).to eq 'N1234567' }
    end

    context 'with format' do
      before do
        Supplier.sequence :number, name: 'sequence', 
                                   format: lambda { |num| num.rjust(10, '0') }
      end
      specify { expect(supplier.number).to eq '0001234567' }
    end

    context 'with prefix and format' do
      before do
        Supplier.sequence :number, name: 'sequence', 
                                   prefix: 'N',
                                   format: lambda { |num| num.rjust(10, '0') }
      end
      specify { expect(supplier.number).to eq 'N0001234567' }
    end
  end
end
