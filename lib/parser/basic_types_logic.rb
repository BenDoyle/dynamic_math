module BasicVariable
  def variables
    [text_value]
  end
end
module NotVariable
  def variables
    []
  end
end
module PiNode
  include NotVariable
  def value(env = { })
    Math::PI
  end
end
module IntegerNode
  include NotVariable
  def value(env = { })
    text_value.to_i
  end
end
module FloatNode
  include NotVariable
  def value(env = { })
    text_value.to_f
  end
end
module VariableNode 
  include BasicVariable
  def value(env = { })
    env[text_value]
  end 
end
