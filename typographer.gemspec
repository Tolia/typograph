# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typograph/version'

Gem::Specification.new do |gem|
  gem.name          = 'typograph'
  gem.version       = Typograph::VERSION
  gem.authors       = ['Tolia']
  gem.email         = ['toliademidov@gmail.com']
  gem.description   = %q{Gem for typographing russian and english texts.}
  gem.summary       = %q{Gem for typographing russian and english texts.}
  gem.homepage      = "https://github.com/Tolia/typograph"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'htmlentities'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
