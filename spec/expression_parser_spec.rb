load 'spec/spec_helper.rb'

# grabbed some spec ideas from "Symbolic" at git://github.com/brainopia/symbolic.git

describe ExpressionParser do

  def self.should_evaluate_to(tests,env = { })
    tests.each_pair do |expression, result|
      it expression do
        (@parser.parse(expression).value(env) - result).abs.should < @tol
      end
    end
  end

  def self.should_simplify_to(tests)
    tests.each_pair do |expression1,expression2|
      it "#{expression1} -> #{expression2}" do
        @parser.parse(expression1).simplify.should == expression2
      end
    end
  end

  before(:each) do
    @parser = ExpressionParser.new
    @tol = 1e-12
  end

  describe 'evaluation' do
    env = { 
      'zero' => 0,
      'x' => 20.0*(rand - 0.5),
      'y' => 20.0*(rand - 0.5),
      'z' => 20.0*(rand - 0.5),
    }
    tests = {
      '01023' => 1023,
      '-01023' => -1023,
      '0.1023' => 0.1023,
      '-0.1023' => -0.1023,
      '-0.1023E23' => -0.1023E23,
      '0.1023e-23' => 0.1023E-23,
      '12+3' => 15,
      '1+2+3+4' => 10,
      '12*3' => 36,
      '1*2*3*4' => 24,
      '1+2*3' => 7,
      '2*3+1' => 7,
      '1*2+3' => 5,
      '3+1*2' => 5,
      'PI + 1' => PI + 1.0,
      '2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0' => 2.0 + 3 * log(2*3.0 +PI) - 2 / 5.0,

      '(1+2)*3' =>  9,
      '-(1+2)*3' =>  -9,
      '(1+2*3)*3' =>  (1+2*3)*3,
      '(2*1+2)*3' =>  (2*1+2)*3,
      'log(2.0)' =>  log(2.0),
      '-log(2.0)' =>  -log(2.0),
      'logistic(2.0)' =>  1/(1+exp(-2)),
      '-logistic(2.0)' =>  -1/(1+exp(-2)),

      'x' => env['x'],
      'y' => env['y'],
      '-x' => -env['x'],
      'x + 4' => env['x']+4,
      '3 + x' => env['x']+3,
      'x + y' => env['x'] + env['y'],
      'x - 1' => env['x']-1,
      '1 - x' => 1-env['x'],
      'x - y' => env['x']-env['y'],
      '-x + 3' => -env['x']+3,
      '-y - x' => -env['x']-env['y'],
      'x*3' => env['x']*3,
      '4*y' => env['y']*4,
      '(x)*(-y)' => -env['x']*env['y'],
      'x/2' => 0.5*env['x'],
      'y/2' => 0.5*env['y'],
      '-2/x' => -2/env['x'],
      '4/(-y)' => -4/env['y'],
      '(1+2.0)*3.1*x' => (1+2.0)*3.1*env['x'],


      'modulo(x,y)' => env['x'].modulo(env['y']),
      'min(x,y)' => [env['x'],env['y']].min,
      'max(x,y)' => [env['x'],env['y']].max,
      'if(x,y,z)' => env['x'] == 0 ? env['z'] : env['y'],
      'if(zero,y,z)' => env['zero'] == 0 ? env['z'] : env['y'],
      'x + y' => env['x'] + env['y'],
      'x - y' => env['x'] - env['y'],
      'x - -2' => env['x'] + 2,
      'x - -y' => env['x'] + env['y'],
      'x * y' => env['x'] * env['y'],
      'x / y' => env['x'] / env['y'],
      'x == y' => 0,
      'x == x' => 1,
      'x != y' => 1,
      'x != x' => 0,
      'x < y' => env['x'] < env['y'] ? 1 : 0,
      'x > y' => env['x'] > env['y'] ? 1 : 0,
      'x < x' => 0, 
      'x > x' => 0,
      'x <= x' => 1,
      'x <= y' => env['x'] <= env['y'] ? 1 : 0,
      'x >= x' => 1,
      'x >= y' => env['x'] >= env['y'] ? 1 : 0,
    }
    should_evaluate_to(tests,env)
  end  

  describe 'simplify:' do
    tests = { 
      '2*0' => '0',
      '2*1' => '2',
      '2+0' => '2',
      '1 * x + x * 1' => 'x + x',
      '0 * x + 2 * 1' => '2',
      '0 * x + 2 * 1 - 0' => '2',
      '0 * x + 2 * 0 - 1' => '-1',


      '-(-x)'       => 'x',
      
      '0 + x'       => 'x',
      'x + 0'       => 'x',
      'x + (-2)'    => 'x - 2',
      '-2 + x'      => 'x - 2',
      '-x + 2'      => '2 - x',
      'x + (-y)'    => 'x - y',
      '-y + x'      => 'x - y',
      
      '0 - x'       => '-x',
      'x - 0'       => 'x',
      'x - (-2)'    => 'x + 2',
      '-2 - (-x)'   => 'x - 2',
      'x - (-y)'    => 'x + y',
      
      '0 * x'       => '0',
      'x * 0'       => '0',
      '1 * x'       => 'x',
      'x * 1'       => 'x',
      '-1 * x'      => '-x',
      'x * (-1)'    => '-x',
      'x * (-3)'    => '-(x*3)',
      '-3 * x'      => '-(x*3)',
      '-3 * (-x)'   => 'x*3',
      'x*(-y)'      => '-(x*y)',
      '-x*y'        => '-(x*y)',
      '(-x)*(-y)'   => 'x*y',
      
      '0 / x'       => '0',
      'x / 1'       => 'x',
      
#      '0**x'        => '0',
#      '1**x'        => '1',
#      'x**0'        => '1',
#      'x**1'        => 'x',
#      '(-x)**1'     => '-x',
#      '(-x)**2'     => 'x**2',
#      '(x**2)**y'   => 'x**(2*y)',
      
#      'x*4*x'       => '4*x**2',
#      'x*(-1)*x**(-1)' => '-1',
#      'x**2*(-1)*x**(-1)' => '-x',
      'x + y - x' => 'y',
#      '2*x + x**1 - y**2/y - y' => '3*x - 2*y',
      '-(x+4)' => '-x-4',
      
      '(x/y)/(x/y)' => '1',
#      '(y/x)/(x/y)' => 'y**2/x**2',
    }
    should_simplify_to(tests)
  end

  it 'should handle symbolic differentiation' do
    @parser.parse('x').partial('x').should   == '1'
    @parser.parse('x*x').partial('x').should == '1 * x + x * 1'
    @parser.parse('2*x').partial('x').should == '0 * x + 2 * 1'
    @parser.parse('2*x-y').partial('x').should == '0 * x + 2 * 1 - 0'
    @parser.parse('2*x-y').partial('y').should == '0 * x + 2 * 0 - 1'
  end

  it 'should compile to language XXX' do
    # compile to native c or fortran, execute-able from ruby
    pending 
  end
end
