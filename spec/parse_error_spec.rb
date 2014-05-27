# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

require "typograph"
require "rspec"

OPT = {
  :ndash => '-'
}

describe 'errors' do

  describe 'quotes' do

    it '#1' do
      text           = "БМК «ПРОСТ»,Библиотека Тургенева приглашают на 2-е заседание дискуссионного клуба 'Дисккуб21'."
      text_processed = "БМК «ПРОСТ»,Библиотека Тургенева приглашают на&nbsp;2-е заседание дискуссионного клуба «Дисккуб21»."
      Typograph.process(text, OPT).should eq text_processed
    end


    it '#2' do
      text           = "Аля Самохина, создатель блога wholesomeway.net, и Аня Сидорова, организатор фитнес-туров Fitness travel, научат готовить необычные блюда из фруктов, зелени, орехов и других полезных продуктов:\n\n"+
                       "— смузи \"Бодрость зелени\";\n\n" +
                       "— мороженое \"Банановый рассвет\";\n\n" +
                       "— пирожное \"Баунти\".\n\n" +
                       "Мастер-класс Али Самохиной и Ани Сидоровой состоится в рамках Делай феста — в секции 'Ланчи-бранчи'. Полная программа «Делай феста»\n"

      text_processed = "Аля Самохина, создатель блога wholesomeway.net, и&nbsp;Аня Сидорова, организатор фитнес-туров Fitness travel, научат готовить необычные блюда из&nbsp;фруктов, зелени, орехов и&nbsp;других полезных продуктов:\n\n"+
                       "— смузи «Бодрость зелени»;\n\n" +
                       "— мороженое «Банановый рассвет»;\n\n" +
                       "— пирожное «Баунти».\n\n" +
                       "Мастер-класс Али Самохиной и&nbsp;Ани Сидоровой состоится в&nbsp;рамках Делай феста&nbsp;— в&nbsp;секции «Ланчи-бранчи». Полная программа «Делай феста»\n"

      Typograph.process(text, OPT).should eq text_processed
    end

  end

  describe 'ampersand' do
    it '#1' do
      text            = '<p>Воркшоп состоится в рамках «Делай феста» — в секции «Арт&amp;Дизайн». Полная программа http://makefest.exchang.es/schedule</p>'
      text_processed  = "<p>Воркшоп состоится в&nbsp;рамках «Делай феста»&nbsp;— в&nbsp;секции «Арт&Дизайн». Полная программа http://makefest.exchang.es/schedule</p>"
      Typograph.process(text, OPT).should eq text_processed
    end
  end

end
