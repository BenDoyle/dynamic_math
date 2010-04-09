module TrinaryFunction
  def variables
    op1.variables + op2.variables + op3.variables
  end
end
module IfNode
  include TrinaryFunction
  def value(env ={ })
    (op1.value(env)==0) ? op3.value(env) : op2.value(env)
  end
  def simplify
    "if(#{op1.simplify}, #{op2.simplify}, #{op3.simplify})"
  end
end
