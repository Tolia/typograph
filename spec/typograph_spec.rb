# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

require "typograph"
require "rspec"

# base_path = File.expand_path('../data', __FILE__);
# Dir.glob(base_path + "/_test.*.dat") do |file|
#   test_name = File.basename(file, ".dat").gsub('_test.', '')
#   describe test_name do
#     test_data = File.open(file, "r:CP1251").read.encode("UTF-8").split("\n\n")
#     test_data.each do |test_item|
#       test_item = test_item.split("\n")
#       input = test_item[0]
#       expected = test_item[1]
#       it input do
#         Typograph.process(input).should eq expected
#       end
#     end
#   end
# end

require 'xmlsimple'

base_path = File.expand_path('../xml', __FILE__);
Dir.glob(base_path + "/*.xml") do |file|
  test_data = XmlSimple.xml_in(File.open(file, "r:UTF-8"))
  test_data['group'].each do |group|
    describe group['description'] do
      group['test'].each do |test|
        input = test['input'][0]
        expected = test['expected'][0]
        it input do
          Typograph.process(input).should eq expected
        end
      end
    end
  end
end

describe Typograph do
  it "ndash option" do
    Typograph.process("кто-то", :ndash => "=").should eq "<nobr>кто=то</nobr>"
    Typograph.process("дай-ка", :ndash => "=").should eq "<nobr>дай=ка</nobr>"
    Typograph.process("кое-кого", :ndash => "=").should eq "<nobr>кое=кого</nobr>"
    Typograph.process("из-за", :ndash => "=").should eq "<nobr>из=за</nobr>"
    Typograph.process("по-над", :ndash => "=").should eq "<nobr>по=над</nobr>"
  end
end
