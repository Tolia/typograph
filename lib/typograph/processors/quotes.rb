module Typograph
  module Processors
    class Quotes

      SPECIAL = {
        :lsquo => '‘',
        :rsquo => '’',
        :sbquo => '‚',
        :ldquo => '“',
        :rdquo => '”',
        :bdquo => '„',
        :quot  => '"',
        :grave => '`',
        :laquo => '«',
        :raquo => '»',
        :acute => '´',
      }
      RU = 'А-я'
      EN = 'A-z'

      def initialize(options={})
      end

      def process(str)
        str = replace_russian_quotes str
        str = replace_english_quotes str
      end

      private

      def replace_russian_quotes(str)
        left1  = SPECIAL[:laquo]
        right1 = SPECIAL[:raquo]
        left2  = SPECIAL[:ldquo]
        right2 = SPECIAL[:rdquo]
        str = replace_quotes str, left1, right1, left2, right2, RU
      end

      def replace_english_quotes(str)
        left1  = SPECIAL[:ldquo]
        right1 = SPECIAL[:rdquo]
        left2  = SPECIAL[:lsquo]
        right2 = SPECIAL[:rsquo]
        str = replace_quotes str, left1, right1, left2, right2, EN
      end

      def replace_quotes(str,left1,right1,left2,right2,letters)
        replace_quotes = lambda do
          old_str = String.new(str)
          str.gsub!(Regexp.new("(\"|\')([#{letters}].*?[^\\s])\\1", Regexp::MULTILINE | Regexp::IGNORECASE)) do |match|
            inside, before, after = $2, $`, $'
            if after.match(/^([^<]+>|>)/) || before.match(/<[^>]+$/)
              match
            else
              "#{left1}#{inside}#{right1}"
            end
          end
          old_str != str
        end
        while replace_quotes.call do end
        replace_second_level_quotes = lambda do 
          regexp = "(#{left1}([^#{right1},.])*)#{left1}(.*)#{right1}(.*#{right1})"
          str.gsub! Regexp.new(regexp, Regexp::MULTILINE | Regexp::IGNORECASE) do |text|
            "#{$1}#{left2}#{$3}#{right2}#{$4}"
          end
        end
        while replace_second_level_quotes.call do end
        str
      end

    end
  end
end