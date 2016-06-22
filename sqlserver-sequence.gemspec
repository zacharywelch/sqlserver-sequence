# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sqlserver/sequence/version'

Gem::Specification.new do |spec|
  spec.name          = "sqlserver-sequence"
  spec.version       = Sqlserver::Sequence::VERSION
  spec.authors       = ["Zac", "Ram"]
  spec.email         = ["zachary.welch@careerbuilder.com",
                        "ramanathan.tirunellaisubramanian@careerbuilder.com"]

  spec.summary       = %q{Sequence number generation in Rails}
  spec.description   = %q{Sequence number generation in Rails}
  spec.homepage      = "https://github.com/zacharywelch/sqlserver-sequence"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_dependency "activerecord", "~> 4.2.0"
  spec.add_dependency 'activerecord-sqlserver-adapter', '~> 4.2.0'
  spec.add_dependency 'tiny_tds'
end
