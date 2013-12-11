# encoding: utf-8
require "typographer/helper"
require "typographer/parser"

module Typograph

  def self.parse(string)
    TypographParser.new(string).parse
  end

end


