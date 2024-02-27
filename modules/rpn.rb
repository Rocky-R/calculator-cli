# frozen_string_literal: true

class Rpn
  def self.calculate(expression, stack)
    valid_operators = %w[+ - * /]
    tokens = expression.split

    tokens.each do |token|
      case token
      when /\d+(\.\d+)?/ # Matches integers and floating point numbers
        stack.push(token.to_f)
      when *valid_operators
        raise "Insufficient operands" if stack.size < 2
        b = stack.pop
        a = stack.pop
        result = a.send(token, b)
        stack.push(result)
      else
        raise "Invalid token: #{token}"
      end
    end

    stack.last
  end
end
