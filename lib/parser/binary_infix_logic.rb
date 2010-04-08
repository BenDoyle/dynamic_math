module BinaryInfix
  include Math
  def variables
    op1.variables + op2.variables
  end
end
module AddNode
  include BinaryInfix
  @@op_char = '+'
  def value(env = { })
    op1.value(env) + op2.value(env)
  end
end
module EqualsNode
  include BinaryInfix
  @@op_char = '='
  def value(env = { })
    op1.value(env) == op2.value(env) ? 1 : 0
  end
end
module NotEqualsNode
  include BinaryInfix
  @@op_char = '!='
  def value(env = { })
    op1.value(env) != op2.value(env) ? 1 : 0
  end
end
module LessThanNode
  include BinaryInfix
  @@op_char = '<'
  def value(env = { })
    op1.value(env) < op2.value(env) ? 1 : 0
  end
end
module GreaterThanNode
  include BinaryInfix
  @@op_char = '>'
  def value(env = { })
    op1.value(env) > op2.value(env) ? 1 : 0
  end
end
module LessThanEqualNode
  include BinaryInfix
  @@op_char = '<='
  def value(env = { })
    op1.value(env) <= op2.value(env) ? 1 : 0
  end
end
module GreaterThanEqualNode
  include BinaryInfix
  @@op_char = '>='
  def value(env = { })
    op1.value(env) >= op2.value(env) ? 1 : 0
  end
end
module MultiplyNode
  include BinaryInfix
  @@op_char = '*'
  def value(env = { })
    op1.value(env) * op2.value(env)
  end
end
module SubtractNode
  include BinaryInfix
  @@op_char = '-'
  def value(env = { })
    op1.value(env) - op2.value(env)
  end
end
module DivideNode
  @@op_char = '/'
  include BinaryInfix
  def value(env = { })
    op1.value(env) / op2.value(env)
  end
end
