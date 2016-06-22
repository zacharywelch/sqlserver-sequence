$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'active_record'
require 'sqlserver/sequence'
require 'activerecord-sqlserver-adapter'
require 'tiny_tds'

# Requires everything in 'spec/support'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

ActiveRecord::Base.establish_connection(
  YAML.load_file("#{File.dirname(__FILE__)}/config.yml")['connection']
)

ActiveRecord::Schema.define do
  create_table :suppliers, force: true do |t|
    t.string :number
  end

  unless ActiveRecord::Base.connection.adapter_name == 'SQLite'
    execute <<-INSERTSEQUENCESQL
      IF NOT EXISTS(SELECT * FROM sys.sequences WHERE name = 'number')
      CREATE SEQUENCE number
      START WITH 1
      INCREMENT BY 1
    INSERTSEQUENCESQL
  end
end
