def calculate(expression, stack)
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
    when 'c'
      stack.clear
      puts "Clearing stack"
    when 'stack'
      puts "Current stack: #{stack}"
    else
      raise "Invalid token: #{token}"
    end
  end

  stack.last
end

def omit_results?(formatted_input)
  utility_commands = %w[stack c]
  formatted_input.empty? || utility_commands.include?(formatted_input)
end

stack = []

begin
  loop do
    print "> "
    input = gets

    break if input.nil? || input.chomp.downcase == 'q'

    begin
      formatted_input = input.chomp.downcase
      result = calculate(formatted_input, stack)
      puts "Result: #{result}" unless omit_results?(formatted_input)
    rescue => e
      puts "Error: #{e.message}"
    end
  end
rescue EOFError, Interrupt
  puts "\nExiting... Goodbye!"
end
