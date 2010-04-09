module PrimaryNode
  def value(env = { })
    if negation.text_value.empty?
      op1.value(env)
    else
      -op1.value(env)
    end
  end
  def variables
    op1.variables
  end
  def partial(variable)
    if negation.text_value.empty?
    "#{op1.partial(variable)}"
    else
    "-#{op1.partial(variable)}"
    end
  end
  def simplify
    if negation.text_value.empty?
    "#{op1.simplify}"
    else
    "-#{op1.simplify}"
    end
  end
end
