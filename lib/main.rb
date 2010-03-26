require 'treetop'
Treetop.load "lib/arithmetic"

parser = ArithmeticParser.new
if parser.parse('1+1')
  puts 'success'
else
  puts 'failure'
end


