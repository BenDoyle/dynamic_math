load 'spec/spec_helper.rb'

describe ExpressionParser do
  before(:each) do
    @parser = ExpressionParser.new
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
  it 'should handle numerical constants' do
    @parser.parse('PI + 1').value.should == Math::PI + 1.0
  end
  it 'should handle big complicated expressions' do
    expr =  2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0
    (@parser.parse('2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0').value - expr).should < @tol
  end
  it 'should handle unary functions' do
    #parens
    @parser.parse('(1+2)*3').value.should == 9
    @parser.parse('-(1+2)*3').value.should == -9
    @parser.parse('(1+2*3)*3').value.should == (1+2*3)*3
    @parser.parse('(2*1+2)*3').value.should == (2*1+2)*3
    @parser.parse('(1+2.0)*3.1*x').value({'x'=>3.2 }).should == (1+2.0)*3.1*3.2
    #log
    @parser.parse('log(2.0)').value.should == log(2.0)
    @parser.parse('-log(2.0)').value.should == -log(2.0)
    #logistic
    @parser.parse('logistic(2.0)').value.should == 1/(1+exp(-2))
    @parser.parse('-logistic(2.0)').value.should == -1/(1+exp(-2))
  end
  it 'should handle binary functions' do
    (@parser.parse('modulo(x,y)').value('x'=>3.2,'y'=>2.0) - 1.2).abs.should < @tol
    (@parser.parse('min(x,y)').value('x'=>3.2,'y'=>2.0) - 2.0).abs.should < @tol
    (@parser.parse('max(x,y)').value('x'=>3.2,'y'=>2.0) - 3.2).abs.should < @tol
  end
  it 'should handle trinary functions' do
    (@parser.parse('if(x,y,z)').value('x'=>3.2,'y'=>2.0,'z'=>7.0) - 2.0).abs.should < @tol
    (@parser.parse('if(x,y,z)').value('x'=>0.0,'y'=>2.0,'z'=>7.0) - 7.0).abs.should < @tol
  end
  it 'should handle binary infix' do
    (@parser.parse('x + y').value('x'=>3.2,'y'=>2.0) - 5.2).abs.should < @tol
    (@parser.parse('x - y').value('x'=>3.2,'y'=>3.2) - 0.0).abs.should < @tol
    (@parser.parse('x - -2').value('x'=>3.2,'y'=>3.2) - 5.2).abs.should < @tol
    (@parser.parse('x - -y').value('x'=>3.2,'y'=>3.2) - 6.4).abs.should < @tol
    (@parser.parse('x * y').value('x'=>3.2,'y'=>2.0) - 6.4).abs.should < @tol
    (@parser.parse('x / y').value('x'=>3.2,'y'=>3.2) - 1.0).abs.should < @tol

    (@parser.parse('x == y').value('x'=>3.2,'y'=>2.0) - 0.0).abs.should < @tol
    (@parser.parse('x == y').value('x'=>3.2,'y'=>3.2) - 1.0).abs.should < @tol
    (@parser.parse('x != y').value('x'=>3.2,'y'=>2.0) - 1.0).abs.should < @tol
    (@parser.parse('x != y').value('x'=>3.2,'y'=>3.2) - 0.0).abs.should < @tol
    (@parser.parse('x < y').value('x'=>3.2,'y'=>2.0) - 0.0).abs.should < @tol
    (@parser.parse('x < y').value('x'=>3.2,'y'=>3.2) - 0.0).abs.should < @tol
    (@parser.parse('x < y').value('x'=>2.2,'y'=>3.2) - 1.0).abs.should < @tol
    (@parser.parse('x > y').value('x'=>3.2,'y'=>2.0) - 1.0).abs.should < @tol
    (@parser.parse('x > y').value('x'=>3.2,'y'=>3.2) - 0.0).abs.should < @tol
    (@parser.parse('x > y').value('x'=>2.2,'y'=>3.2) - 0.0).abs.should < @tol
    (@parser.parse('x <= y').value('x'=>3.2,'y'=>2.0) - 0.0).abs.should < @tol
    (@parser.parse('x <= y').value('x'=>3.2,'y'=>3.2) - 1.0).abs.should < @tol
    (@parser.parse('x <= y').value('x'=>2.2,'y'=>3.2) - 1.0).abs.should < @tol
    (@parser.parse('x >= y').value('x'=>3.2,'y'=>2.0) - 1.0).abs.should < @tol
    (@parser.parse('x >= y').value('x'=>3.2,'y'=>3.2) - 1.0).abs.should < @tol
    (@parser.parse('x >= y').value('x'=>2.2,'y'=>3.2) - 0.0).abs.should < @tol
  end
  
  it 'should handle symbolic differentiation' do
    @parser.parse('x').partial('x').text_value.should == '1'
    @parser.parse('x*x').partial('x').text_value.should == 'x+x'
  end
end
