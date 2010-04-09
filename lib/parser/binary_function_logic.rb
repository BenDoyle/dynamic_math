module BinaryFunction
  include Math
  def variables
    op1.variables + op2.variables
  end
end
module ModuloNode
  include BinaryFunction
  def value(env ={ })
    op1.value(env).modulo(op2.value(env))
  end
  def simplify
    "modulo( #{op1.simplify}, #{op2.simplify}"
  end
end
module MinNode
  include BinaryFunction
  def value(env ={ })
    [ op1.value(env), op2.value(env) ].min
  end
  def simplify
    "min( #{op1.simplify}, #{op2.simplify}"
  end
end
module MaxNode
  include BinaryFunction
  def value(env ={ })
    [ op1.value(env), op2.value(env) ].max
  end
  def simplify
    "max( #{op1.simplify}, #{op2.simplify}"
  end
end
