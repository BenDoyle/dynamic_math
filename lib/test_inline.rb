require 'benchmark'
require 'inline'

class MyTest

  def factorial(n)
    f = 1
    n.downto(2) { |x| f *= x }
    f
  end

const = 2

  inline :C do |builder|
    builder.c "
    long factorial_c(int max) {
      int i=max, result=1;
      while (i >= #{const}) { result *= i--; }
      return result;
    }"
  end
end

t = MyTest.new

num = 12
Benchmark.bm do |bm|
  bm.report { puts t.factorial(num) }
  bm.report { puts t.factorial_c(num) }
end
