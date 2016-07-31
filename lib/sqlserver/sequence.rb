require 'active_support/concern'
require 'sqlserver/sequence/configuration'
require 'sqlserver/sequence//strategies'
require 'sqlserver/sequence/version'

module Sqlserver
  module Sequence
    extend ActiveSupport::Concern

    module ClassMethods
      def sequence(field, options = {})
        unless defined?(sequences)
          include Sqlserver::Sequence::InstanceMethods
          include next_value_strategy

          class_attribute :sequences
          self.sequences = {}
    
          before_create :set_sequences
        end

        default_options = { name: field.to_s, format: nil, prefix: nil }
        self.sequences[field] = default_options.merge(options)
      end

      private

      def next_value_strategy
        Sqlserver::Sequence.configuration.next_value_strategy || 
          Strategies::NextValueFor
      end
    end

    module InstanceMethods
      
      private

      def set_sequences
        sequences.each do |field, options|
          name = options[:name]
          prefix = options[:prefix]
          format = options[:format]

          value = next_sequence_value(name).to_s
          value = format.call(value) if format.respond_to?(:call)
          send "#{field}=", [prefix, value].join
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Sqlserver::Sequence
