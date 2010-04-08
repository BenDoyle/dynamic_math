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
end
