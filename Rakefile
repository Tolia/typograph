require "bundler/gem_tasks"

require 'rspec/core/rake_task'
desc "Run all specs"
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

LANG = "ru_RU.UTF-8"

SET_CMD = case RUBY_PLATFORM 
  when /mingw32/ then 
    "set"
  else 
    "export"
  end

desc "run tests"
task :test do
  sh "#{SET_CMD} LANG=#{LANG} && chcp 65001 && bundle exec rake"
end
