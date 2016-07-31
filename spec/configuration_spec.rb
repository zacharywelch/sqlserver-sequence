require 'spec_helper'

describe Sqlserver::Sequence::Configuration do

  context 'when next_value_strategy is set' do    
    let(:mock_strategy) { Module.new }
    
    before do    
      Sqlserver::Sequence.configure do |config|
        config.next_value_strategy = mock_strategy
      end

      spawn_model(:Supplier) { sequence :number }
    end

    it 'includes that strategy' do
      expect(Supplier.new).to be_kind_of(mock_strategy)
    end
  end

  context 'when next_value_strategy is not set' do   
    before do
      Sqlserver::Sequence.configure do |config|
        config.next_value_strategy = nil
      end

      spawn_model(:Supplier) { sequence :number }
    end

    it 'includes Sqlserver::NextValueStrategies::NextValueFor' do
      expect(Supplier.new).to be_kind_of(
        Sqlserver::Sequence::Strategies::NextValueFor
      )
    end
  end
end
