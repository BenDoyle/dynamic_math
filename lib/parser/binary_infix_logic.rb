module BinaryInfix
  include Math
  def variables
    op1.variables + op2.variables
  end
end
module EqualsNode
  include BinaryInfix
  @@op_char = '=='
  def value(env = { })
    op1.value(env) == op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} == #{op2.simplify}"
  end
end
module NotEqualsNode
  include BinaryInfix
  @@op_char = '!='
  def value(env = { })
    op1.value(env) != op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} != #{op2.simplify}"
  end
end
module LessThanNode
  include BinaryInfix
  @@op_char = '<'
  def value(env = { })
    op1.value(env) < op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} < #{op2.simplify}"
  end
end
module GreaterThanNode
  include BinaryInfix
  @@op_char = '>'
  def value(env = { })
    op1.value(env) > op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} > #{op2.simplify}"
  end
end
module LessThanEqualNode
  include BinaryInfix
  @@op_char = '<='
  def value(env = { })
    op1.value(env) <= op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} <= #{op2.simplify}"
  end
end
module GreaterThanEqualNode
  include BinaryInfix
  @@op_char = '>='
  def value(env = { })
    op1.value(env) >= op2.value(env) ? 1 : 0
  end
  def simplify
    "#{op1.simplify} >= #{op2.simplify}"
  end
end
module AddNode
  include BinaryInfix
  @@op_char = '+'
  def value(env = { })
    op1.value(env) + op2.value(env)
  end
  def partial(variable)
    "#{op1.partial(variable)} + #{op2.partial(variable)}"
  end
  def simplify
    result = "#{op1.simplify} + #{op2.simplify}"
    if op1.simplify == '0' and op2.simplify == '0'
      result = "0"
    end
    if op1.simplify == '0'
      result = op2.simplify
    end
    if op2.simplify == '0'
      result = op1.simplify
    end
    if op2.respond_to? :negation
      unless op2.negation.text_value.empty?
        result = "#{op1.simplify} - #{op2.op1.simplify}"
      end
    end
    result.sub('- -','+ ').sub('+ -','- ')
  end
end
module SubtractNode
  include BinaryInfix
  @@op_char = '-'
  def value(env = { })
    op1.value(env) - op2.value(env)
  end
  def partial(variable)
    "#{op1.partial(variable)} - #{op2.partial(variable)}"
  end
  def simplify
    result = "#{op1.simplify} - #{op2.simplify}"
    if op1.simplify == '0' and op2.simplify == '0'
      result = "0"
    end
    if op1.simplify == '0'
      result = "-#{op2.simplify}"
    end
    if op2.simplify == '0'
      result = op1.simplify
    end
    result.sub('- -','+ ').sub('+ -','- ')
  end
end
module MultiplyNode
  include BinaryInfix
  @@op_char = '*'
  def value(env = { })
    op1.value(env) * op2.value(env)
  end
  def partial(variable)
    "#{op1.partial(variable)} * #{op2.text_value} + #{op1.text_value} * #{op2.partial(variable)}"
  end
  def simplify
    result = "#{op1.simplify} * #{op2.simplify}"
    if op2.extension_modules.include? NotVariable
      result = "#{op2.simplify} * #{op1.simplify}"
    end
    if op1.simplify == '0' or op2.simplify == '0'
      result = "0"
    end
    if op1.simplify == '1'
      result = op2.simplify
    end
    if op2.simplify == '1'
      result = op1.simplify
    end
    if op1.simplify == '-1'
      result = "-#{op2.simplify}"
    end
    if op2.simplify == '-1'
      result = "-#{op1.simplify}"
    end
    result
  end
end
module DivideNode
  @@op_char = '/'
  include BinaryInfix
  def value(env = { })
    op1.value(env) / op2.value(env)
  end
  def partial(variable)
    "( #{op1.partial(variable)} * #{op2.text_value} - #{op1.text_value} * #{op2.partial(variable)} ) / ( (#{op2.text_value} * #{op2.text_value} )"
  end
  def simplify
    result = "#{op1.simplify} / #{op2.simplify}"
    if op1.simplify == op2.simplify
      result = '1'
    end
    if op2.simplify == '0'
      result = 'NaN'
    end
    if op1.simplify == '0'
      result = '0'
    end
    if op1.simplify == '1'
      result = op2.simplify
    end
    if op2.simplify == '1'
      result = op1.simplify
    end
    result
  end
end
