# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notebook/version'

Gem::Specification.new do |spec|
  spec.name          = 'notebook'
  spec.version       = Notebook::VERSION
  spec.authors       = 'Jon Moss'
  spec.email         = 'me@jonathanmoss.me'

  spec.summary       = 'A simple Ruby file uploader library'
  spec.description   = 'A simple Ruby file uploader library'
  spec.homepage      = 'https://github.com/moss-rb/notebook'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aws-sdk'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
end
