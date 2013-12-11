class TypographParser

  OPTIONS = {
    abbr: 'ООО|ОАО|ЗАО|ЧП|ИП|НПФ|НИИ|ООО\p{Zs}ТПК',
    prepos: 'а|в|во|вне|и|к|о|с|у|со|об|обо|от|ото|то|на|не|ни|но|из|изо|за|уж|на|по|подо|пред|предо|про|над|надо|как|без|безо|да|до|там|ещё|их|ко|меж|между|перед|передо|около|через|сквозь|при|я',
    nobr: {
      open:  "<nobr>",
      close: "</nobr>"
    },
  }


  def initialize(text)
    @text = text
  end

  def parse

    # russian quotes
    @text = replace_quotes @text, '&laquo;', '&raquo;', '&#132;', '&#147;', 'а-яА-Я'

    # english quotes
    @text = replace_quotes @text

    # regexp
    replaces.each do |replacement|
      @text.gsub!(replacement[0], replacement[1])
    end
    
    @text
  end

private

  def replaces
    [
      #non brake space
      [ /(^|\s|\()(\p{Word}{1,2})\s+([^\s])/, '\1\2&nbsp;\3' ],
      [ /(^|\s|\()&([A-Za-z0-9]{1,8}|#[\d]*);(\p{Word}{1,2})\s+([^\s])/, '\1&\2;\3&nbsp;\4' ], #entities
      [ /(&nbsp;|&#161;|&laquo;|&#147;)(\p{Word}{1,2})\s+([^\s])/, '\1\2&nbsp;\3\4' ],

      #apostrophe
      [ /“/, '&#132;' ],
      [ /”/, '&#147;' ],

      #mdash
      [ /--/, '&mdash;' ],

      [ /(\p{Word}|;|,)\s+(—|–|-)\s*(\p{Word})/, '\1&nbsp;&mdash; \3' ],
      [ /\s+&mdash;/, '&nbsp;&mdash;' ],

      #nobr
      #around dash-separated words (что-то)
      [ /(^|\s)((\p{Word}|0-9){1,3})-((\p{Word}|0-9){1,3})($|\s)/, '\1<nobr>\2-\4</nobr>\6' ],
      #1980-x почему-то
      [ /(^|\s)((\p{Word}|0-9)+)-((\p{Word}|0-9){1,3})($|\s)/, '\1<nobr>\2-\4</nobr>\6' ],
   
      #Ё -> е
      [ /Ё/, 'Е' ],
      [ /ё/, 'е' ],

      # Расстановка дефисов в предлогах «из-за», «из-под», «по-над», «по-под»
      [ /\b(из)[\s-]?(за|под)\b/,  "#{ OPTIONS[:nobr][:open] }\\1&mdash;\\2#{ OPTIONS[:nobr][:close] }" ],
      [ /\b(по)[\s-]?(над|под)\b/, "#{ OPTIONS[:nobr][:open] }\\1&mdash;\\2#{ OPTIONS[:nobr][:close] }" ],

      # replace single quote between letters to apostrophe
      [ /([a-zA-Z]+)'([a-zA-Z]+)/, '\1&#146;\2'],

      # Слепляем скобки со словами
      [ /\( /, '('],
      [ / \)/, ')'],
      # Оторвать скобку от слова
      [ /(\p{L})\(/, '\1 ('],
      [ /\) ([.|,])/, ')\1'],
    ]
  end

  def replace_quotes(string, left1='&#147;', right1='&#148;', left2='&#145;', right2='&#146;', letters = 'a-zA-Z')
    str = string.dup

    _replace_quotes = lambda do
      old_str = str.dup
      str.gsub!(Regexp.new("(\"|\'|&quot;)((\s*<[^>]+>\s*)?[#{letters}]((<[^>]+>)|.)*?[^\\s])\\1", Regexp::MULTILINE | Regexp::IGNORECASE)) do |match|
        inside, before, after = $2, $`, $'
        if after.match(/^([^<]+>|>)/) || before.match(/<[^>]+$/) #inside tag
          match
        else
          "#{left1}#{inside}#{right1}"
        end
      end
      old_str != str
    end
    while _replace_quotes.call do end

    # second level
    str.gsub!('&', "\0&")
    _replace_second_level_quotes = lambda do
      str.gsub! Regexp.new("#{left1}([^\0`]*)\0#{left1}([^\0]*)\0#{right1}", Regexp::MULTILINE | Regexp::IGNORECASE) do
        "#{left1}#{$1}#{left2}#{$2}#{right2}"
      end
    end
    while _replace_second_level_quotes.call do end
    str.gsub!("\0", '')

    str
  end

end