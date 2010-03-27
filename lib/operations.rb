module AddNode
  def value(env = { })
    op1.value(env) + op2.value(env)
  end
end
module MultiplyNode
  def value(env = { })
    op1.value(env) * op2.value(env)
  end
end
module SubtractNode
  def value(env = { })
    op1.value(env) - op2.value(env)
  end
end
module DivideNode
  def value(env = { })
    op1.value(env) / op2.value(env)
  end
end
module ParensNode
  def value(env = { })
    additive.value(env)
  end
end
module IntegerNode
  def value(env = { })
    text_value.to_i
  end
end
module FloatNode
  def value(env = { })
    text_value.to_f
  end
end
module VariableNode
  def value(env = { })
    env[name]
  end 
  def name
    text_value
  end
end
