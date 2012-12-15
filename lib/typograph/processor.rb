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

    def safe_blocks
      @pattern ||= begin
        pattern = SAFE_BLOCKS.map do |val|
          val.join('.*?')
        end.join('|')
        Regexp.new("(#{pattern}|<[^>]*[\\s][^>]*>)", Regexp::IGNORECASE | Regexp::MULTILINE)
      end
    end

    # Вызывает типограф, обходя html-блоки и безопасные блоки
    def process(str)
      str = @profile.normalize(str)
      
      @safe_blocks = {}
      str.gsub!(safe_blocks) do |match|
        key = "<#{@safe_blocks.length}>"  
        @safe_blocks[key] = match
        key
      end

      str = @profile.process(str)

      if @safe_blocks
        str.gsub! /(<\d>)/ do |match|
          @safe_blocks[match]
        end
      end
      @safe_blocks = {}

      # выдераем дублирующиеся nowrap
      str.gsub!(/(\<(\/?nobr)\>)+/i, '\1')
      str.gsub! /<nobr>(.*?)<\/nobr>/ do |match|
        match.to_s.gsub('&nbsp;', ' ')
      end
    
      str
    end

    def initialize(options = {})
      @profile = Adapters::Russian.new options
    end
  end
end