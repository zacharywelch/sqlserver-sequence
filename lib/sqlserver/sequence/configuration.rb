module Sqlserver
  module Sequence
    class Configuration
      # The next value strategy is used when generating the next sequence value.
      # Defaults to {Sqlserver::Sequence::Strategies::NextValueFor}.
      attr_accessor :next_value_strategy
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configuration=(config)
      @configuration = config
    end

    def self.configure
      yield configuration
    end
  end
end
