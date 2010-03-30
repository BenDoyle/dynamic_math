require 'treetop'
load "lib/parser/basic_types_logic.rb"
load "lib/parser/arithmetic_logic.rb"
Treetop.load "lib/parser/basic_types"
Treetop.load "lib/parser/arithmetic"
include Math

describe ArithmeticParser do
  before(:each) do
    @parser = ArithmeticParser.new
    @tol = 1e-12
  end
  it 'should handle an integer' do
    @parser.parse('01023').value.should == 1023
  end
  it 'should handle an integer' do
    @parser.parse('-01023').value.should == -1023
  end
  it 'should handle a float' do
    @parser.parse('0.1023').value.should == 0.1023
  end
  it 'should handle a float' do
    @parser.parse('-0.1023').value.should == -0.1023
  end
  it 'should handle scientific notation' do
    @parser.parse('-0.1023E23').value.should == -0.1023E23
  end
  it 'should handle scientific notation' do
    @parser.parse('0.1023e-23').value.should == 0.1023E-23
  end
  it 'should handle variables' do
    @parser.parse('x').value({'x'=> 23}).should == 23
  end
  it 'should handle a simple addition' do
    @parser.parse('12+3').value.should == 15
  end
  it 'should handle a compound addition' do
    @parser.parse('1+2+3+4').value.should == 10
  end
  it 'should handle a simple multiplication' do
    @parser.parse('12*3').value.should == 36
  end
  it 'should handle a compoud multiplication' do
    @parser.parse('1*2*3*4').value.should == 24
  end
  it 'should handle order of operations' do
    @parser.parse('1+2*3').value.should == 7
    @parser.parse('2*3+1').value.should == 7
    @parser.parse('1*2+3').value.should == 5
    @parser.parse('3+1*2').value.should == 5
  end
  it 'should handle parens' do
    @parser.parse('(1+2)*3').value.should == 9
    @parser.parse('(1+2*3)*3').value.should == (1+2*3)*3
    @parser.parse('(2*1+2)*3').value.should == (2*1+2)*3
  end
  it 'should handle parens and substitutions' do
    @parser.parse('(1+2.0)*3.1*x').value({'x'=>3.2 }).should == (1+2.0)*3.1*3.2
  end
  it 'should handle funtions' do
    @parser.parse('log(2.0)').value.should == log(2.0)
  end
  it 'should handle numerical constants' do
    @parser.parse('PI + 1').value.should == Math::PI + 1.0
  end
  it 'should handle big complicated expressions' do
    expr =  2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0
    (@parser.parse('2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0').value - expr).should < @tol
  end
end
