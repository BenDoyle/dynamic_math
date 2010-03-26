require 'treetop'
load 'lib/operations.rb'
Treetop.load "lib/arithmetic"

describe ArithmeticParser do
  before(:each) do
    @parser = ArithmeticParser.new
  end
  it 'should handle a number' do
    @parser.parse('123').value.should == 123
  end
  it 'should handle a simple addition' do
    @parser.parse('12+3').value.should == 15
  end
  it 'should handle a simple multiplication' do
    @parser.parse('12*3').value.should == 36
  end
  it 'should handle order of operations' do
    @parser.parse('1+2*3').value.should == 7
    @parser.parse('1*2+3').value.should == 5
  end
  it 'should handle parens' do
    @parser.parse('(1+2)*3').value.should == 9
  end
end
