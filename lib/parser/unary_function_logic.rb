module UnaryFunction
  include Math
  def variables
    op1.variables
  end
end
module LogNode
  include UnaryFunction
  def value(env = { })
    Math::log(op1.value(env))
  end
end
module LogisticNode
  include UnaryFunction
  def value(env = { })
    1/(1+exp(-op1.value(env)))
  end
end
module ParensNode
  include UnaryFunction
  def value(env = { })
    op1.value(env)
  end
end
