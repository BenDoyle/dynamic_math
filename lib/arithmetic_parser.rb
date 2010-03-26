require 'treetop'
load 'lib/operations.rb'
Treetop.load "lib/arithmetic"

class ArithmeticParser
  def initialize
    parser = ArithmeticParser.new
    if parser.parse('1+1')
      puts 'success'
    else
      puts 'failure'
    end
  end
end
