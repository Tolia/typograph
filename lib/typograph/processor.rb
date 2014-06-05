# encoding: utf-8

module Typograph
  class Processor

    DEFAULTS = {}

    SAFE_BLOCKS = [
      ['<pre[^>]*>','</pre>'],
      ['<style[^>]*>','</style>'],
      ['<script[^>]*>','</script>'],
      ['<!--','-->'],
      ['<code[^>]*>','</code>']
    ]

    def initialize(options={})
      @adapter         = Adapter.new options
      @russian_grammar = Processors::RussianGrammar.new options
      @quotes          = Processors::Quotes.new options
    end

    def safe_blocks
      @pattern ||= begin
        pattern = SAFE_BLOCKS.map do |val|
          val.join('.*?')
        end.join('|')
        Regexp.new("(#{pattern}|<[^>]*[\\s][^>]*>)", Regexp::IGNORECASE | Regexp::MULTILINE)
      end
    end

    def process(str)
      str = @adapter.normalize(str)
      
      @safe_blocks = {}
      str.gsub!(safe_blocks) do |match|
        key = "<#{@safe_blocks.length}>"  
        @safe_blocks[key] = match
        key
      end

      str = @quotes.process str
      str = @russian_grammar.process str
      

      if @safe_blocks
        str.gsub! /(<\d>)/ do |match|
          @safe_blocks[match]
        end
      end
      @safe_blocks = {}
    
      str
    end

  end
end