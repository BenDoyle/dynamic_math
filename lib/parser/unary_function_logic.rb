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
  def partial(variable)
    "1 / ( #{op1.partial(variable)} )"
  end
  def simplify
    "log(#{op1.simplify})"
  end
end
module LogisticNode
  include UnaryFunction
  def value(env = { })
    1/(1+exp(-op1.value(env)))
  end
  def partial(variable)
    "logistic( #{op1.text_value} ) * ( 1 - logistic( #{op1.text_value} ) ) * ( #{op1.partial(variable)} )"
  end
  def simplify
    "logistic(#{op1.simplify})"
  end
end
module ParensNode
  include UnaryFunction
  def value(env = { })
    op1.value(env)
  end
  def partial(variable)
    "( #{op1.partial(variable)} )"
  end
  def simplify
    "(#{op1.simplify})"
  end
end
