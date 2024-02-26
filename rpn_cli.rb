def calculate(expression, last_result)
  valid_operators = %w[+ - * /]
  tokens = expression.split
  stack = []

  stack.push(last_result.to_f) if last_result

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

  raise "Too many operands" if stack.size > 1
  stack.pop
end

last_result = nil

begin
  loop do
    print "> "
    input = gets
    break if input.nil? || input.chomp.downcase == 'q'

    begin
      result = calculate(input.chomp, last_result)
      puts result.to_s
      last_result = result
    rescue => e
      puts "Error: #{e.message}"
    end
  end
rescue EOFError, Interrupt
  puts "\nExiting... Goodbye!"
end
