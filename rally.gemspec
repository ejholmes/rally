# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rally/version'

Gem::Specification.new do |spec|
  spec.name          = 'rally'
  spec.version       = Rally::VERSION
  spec.authors       = ['Eric J. Holmes', 'Chris Warren']
  spec.email         = ['eric@ejholmes.net']
  spec.description   = %q{An API for tying cloud services together}
  spec.summary       = %q{An API for tying cloud services together}
  spec.homepage      = 'https://github.com/remind101/rally'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'hashie'
  spec.add_dependency 'grape'
  spec.add_dependency 'grape-entity'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'cucumber'
end
