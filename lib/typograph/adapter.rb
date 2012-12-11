# encoding: utf-8

require 'htmlentities'

module Typograph
  class Adapter
    def initialize(options={})
      @options = options
    end

    def process(text)

    end

    # Приводим символы в строке к единой форме для последующей обработки
    def normalize(str)
      # Убираем неразрывные пробелы
      str.gsub!(/&nbsp;| /, ' ')
      # Приводим кавычки к «"»
      str.gsub!(/(„|“|&quot;)/, '"')
      # 
      str.chomp(" \r\n\t")
      HTMLEntities.new.decode(str)
    end
  end
end