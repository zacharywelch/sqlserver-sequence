require 'spec_helper'

describe Sqlserver::Sequence::Strategies::Simple do  
  
  before do
    Sqlserver::Sequence.configure do |config|
      config.next_value_strategy = Sqlserver::Sequence::Strategies::Simple
    end

    spawn_model(:Supplier) { sequence :number }
  end

  describe 'saving' do

    let!(:supplier) { Supplier.create }
    let!(:other_supplier) { Supplier.create }

    it 'returns the next value' do
      expect(other_supplier.number).to be > supplier.number
    end

    it 'uses the maximum id' do
      expected = Supplier.maximum(:id).next.to_s
      expect(Supplier.create.number).to eq expected
    end
  end
end
