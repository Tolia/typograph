# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

require "typograph"
require "rspec"

describe "Typograph options" do
  it "ndash option" do
    Typograph.process("кто-то", :ndash => "=").should eq "<nobr>кто=то</nobr>"
    Typograph.process("дай-ка", :ndash => "=").should eq "<nobr>дай=ка</nobr>"
    Typograph.process("кое-кого", :ndash => "=").should eq "<nobr>кое=кого</nobr>"
    Typograph.process("из-за", :ndash => "=").should eq "<nobr>из=за</nobr>"
    Typograph.process("по-над", :ndash => "=").should eq "<nobr>по=над</nobr>"
  end
end