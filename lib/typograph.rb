require "typograph/version"
require "typograph/adapter"
require "typograph/processors/quotes"
require "typograph/processors/russian_grammar"
require "typograph/processor"

module Typograph
  def self.process(text="", options={})
    return "" if text.nil?
    Processor.new(options).process(text)
  end
end
