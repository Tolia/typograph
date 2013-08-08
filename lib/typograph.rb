require "typograph/version"
require "typograph/processor"
require "typograph/adapter"
require "typograph/adapters/russian"

module Typograph
  def self.process(text="", options={})
    return "" if text.nil?
    Processor.new(options).process(text)
  end
end
