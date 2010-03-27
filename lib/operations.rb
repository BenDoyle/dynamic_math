module AdditiveNode
  def value(env ={ })
    multitive.value + additive.value
  end
end

module MultitiveNode
  def value(env ={ })
    multitive.value * primary.value
  end
end

module PrimaryNode
  def value(env ={ })
    additive.value
  end
end

module IntegerNode
  def value(env ={ })
    text_value.to_i
  end
end

module FloatNode
  def value(env ={ })
    text_value.to_f
  end
end

module VariableNode
  def value(env ={ })
    env[name]
  end 
  def name
    text_value
  end
end
