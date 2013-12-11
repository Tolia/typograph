# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typographer/version'

Gem::Specification.new do |gem|
  gem.name          = TypographerHelper::GEM_NAME
  gem.version       = TypographerHelper::VERSION
  gem.authors       = []
  gem.email         = []
  gem.description   = %q{Gem for typographing russian texts.}
  gem.summary       = %q{Gem for typographing russian texts.}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'htmlentities'

  gem.add_development_dependency 'xml-simple'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
