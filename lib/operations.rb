class AdditiveNode < Treetop::Runtime::SyntaxNode
  def value
    multitive.value + additive.value
  end
end

class MultitiveNode < Treetop::Runtime::SyntaxNode
  def value
    multitive.value * primary.value
  end
end

class PrimaryNode < Treetop::Runtime::SyntaxNode
  def value
    additive.value
  end
end

class NumberNode < Treetop::Runtime::SyntaxNode
  def value
    (first_digit.text_value + rest_digits.text_value).to_i
  end
end
