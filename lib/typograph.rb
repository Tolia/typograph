require "typograph/version"
require "typograph/processor"

module Typograph
  def self.process(text, options = {})
    Processor.new(options).process(text)
  end
end
