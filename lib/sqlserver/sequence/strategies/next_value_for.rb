module Sqlserver
  module Sequence
    module Strategies
      module NextValueFor
        def next_sequence_value(sequence_name)
          self.class.connection.select_value(
            "select next value for #{sequence_name}"
          )
        end
      end
    end
  end
end
