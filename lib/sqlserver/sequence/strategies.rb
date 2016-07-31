module Sqlserver
  module Sequence
    module Strategies
      autoload :NextValueFor, 'sqlserver/sequence/strategies/next_value_for'
      autoload :Simple, 'sqlserver/sequence/strategies/simple'
    end
  end
end
