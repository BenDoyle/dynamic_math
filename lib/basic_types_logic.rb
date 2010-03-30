module PiNode
  def value(env = { })
    Math::PI
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
  def data_structure
    text_value
  end
end
