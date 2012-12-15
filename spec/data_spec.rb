# encoding: utf-8
# $KCODE = "utf-8" if defined?($KCODE)

# require "typograph"
# require "rspec"

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
