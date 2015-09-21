# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hipay/version'

Gem::Specification.new do |spec|
  spec.name          = "hipay"
  spec.version       = Hipay::VERSION
  spec.authors       = ["itkin"]
  spec.email         = ["nicolas.papon@gmail.com"]
  spec.summary       = %q{Hipay client.}
  spec.description   = %q{Hipay client.}
  spec.homepage      = ""
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency "activesupport"
  spec.add_dependency 'savon'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
