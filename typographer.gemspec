# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'typographer/version'

Gem::Specification.new do |s|
  s.name    = TypographerHelper::GEM_NAME
  s.version = TypographerHelper::VERSION
  s.summary = "#{TypographerHelper::GEM_NAME}-#{TypographerHelper::VERSION}"
  s.description = "This gem makes text more readable by applying some typographic rules to string.\nThis is a fork of original typography gem."
  s.files = Dir.glob("{lib,spec}/**/*") + ["README.rdoc", "Rakefile", "Changelog", "Gemfile", "init.rb"]

  s.test_files = Dir.glob("spec/**/*")
  s.require_path = "lib"
  s.extra_rdoc_files = ["README.rdoc"]
  s.rdoc_options = ["--main", "README.rdoc"]

  s.add_dependency "actionpack", '>= 3.1.0'
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "autotest"
end
