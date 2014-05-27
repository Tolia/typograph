# encoding: utf-8

require 'htmlentities'

module Typograph
  class Adapter

    SPECIAL = {
      :lsquo => '‘',
      :rsquo => '’',
      :sbquo => '‚',
      :ldquo => '“',
      :rdquo => '”',
      :bdquo => '„',
      :lsaquo =>  '‹',
      :rsaquo => '›',
      :quot => '"',
      :grave => '`',
      :laquo => '«',
      :raquo => '»',
      :acute => '´',
      :hellip => '…',
      :ndash => '–',
      :mdash => '—',
      :nbsp => "\xA0",
      :shy => "\xAD",
      :cent => '¢',
      :pound => '£',
      :curren => '¤',
      :yen => '¥',
      :sect => '§',
      :sup2 => '²',
      :sup3 => '³'
    }

    def initialize(options={})
      @options = options
    end

    def process(text)

    end

    def sym_to_char(sym)
      res = SPECIAL[sym]
      raise ArgumentError, "Unknown sym #{sym}" unless res
      res
    end

    def normalize(str)
      str.gsub!(/&nbsp;| /, ' ')
      str.chomp(" \r\n\t")
      HTMLEntities.new.decode(str)
    end
  end
end