# encoding: utf-8

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'primary_key_replacer/version'

Gem::Specification.new do |spec|
  spec.name          = 'primary_key_replacer'
  spec.version       = PrimaryKeyReplacer::VERSION
  spec.authors       = ['Sebastián Katzer']
  spec.email         = ['katzer.sebastian@googlemail.com']
  spec.description   = %q{ActiveRecord plugin to replace the primary key type}
  spec.summary       = %q{ActiveRecord plugin to replace the primary key type}
  spec.homepage      = 'https://github.com/katzer/primary_key_type_replacer'
  spec.license       = 'GPL v2'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new '>= 1.9.2'

  spec.add_dependency 'activerecord', '>= 3.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
