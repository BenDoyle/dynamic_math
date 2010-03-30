include Math
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
module LogNode
  def value(env = { })
    Math::log(additive.value(env))
  end
end
module ParensNode
  def value(env = { })
    additive.value(env)
  end
end




