# encoding: utf-8
require 'action_view'

module ActionView::Helpers::TextHelper
  
  def ty(text)
    TypographerHelper.parse text.to_s
  end

end
