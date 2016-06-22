require 'active_support/concern'
require 'sqlserver/sequence/version'

module Sqlserver
  module Sequence
    extend ActiveSupport::Concern

    class_methods do
      def sequence(field, options = {})
        unless defined?(sequences)
          include Sqlserver::Sequence::InstanceMethods
    
          class_attribute :sequences
          self.sequences = {}
    
          before_create :set_sequences
        end

        default_options = { name: field.to_s, format: nil, prefix: nil }
        self.sequences[field] = default_options.merge(options)
      end
    end

    module InstanceMethods
      
      def next_sequence_value(sequence_name)
        self.class.connection.select_value(
          "select next value for #{sequence_name}"
        )
      end

      private

      def set_sequences
        sequences.each do |field, options|
          name = options[:name]
          prefix = options[:prefix]
          format = options[:format]

          value = next_sequence_value(name)
          value = format.call(value) if format.respond_to?(:call)
          send "#{field}=", [prefix, value].join
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Sqlserver::Sequence
