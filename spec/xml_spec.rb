# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

# require "typograph"
# require "rspec"
# require 'xmlsimple'

# base_path = File.expand_path('../xml', __FILE__);
# Dir.glob(base_path + "/*.xml") do |file|
#   test_data = XmlSimple.xml_in(File.open(file, "r:UTF-8"))
#   test_data['group'].each do |group|
#     describe group['description'] do
#       group['test'].each do |test|
#         input = test['input'][0]
#         expected = test['expected'][0]
#         it input do
#           Typograph.process(input).should eq expected
#         end
#       end
#     end
#   end
# end
