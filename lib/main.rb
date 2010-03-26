require 'treetop'
load 'lib/operations.rb'
Treetop.load "lib/arithmetic"

parser = ArithmeticParser.new
if parser.parse('1+1')
  puts 'success'
else
  puts 'failure'
end

puts parser.parse('1+2').value
