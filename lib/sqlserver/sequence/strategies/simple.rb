module Sqlserver
  module Sequence
    module Strategies
      module Simple
        def next_sequence_value(sequence_name)
          self.class.maximum(:id).to_i.next
        end
      end
    end
  end
end
