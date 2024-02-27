Dir[File.join('.', 'modules', '*.rb')].each { |file| require file }

UTILITY_COMMANDS = %w[stack c]

def omit_results?(formatted_input, result)
  formatted_input.empty? || result.nil?
end

def run_utility_command(command, stack)
  case command
  when 'c'
    stack.clear
    puts "Clearing stack"
  when 'stack'
    puts "Current stack: #{stack}"
  else
    puts "Invalid command: #{command}"
  end
end

stack = []

begin
  loop do
    print "> "
    input = gets

    break if input.nil?

    formatted_input = input.chomp.downcase

    begin
      case formatted_input
      when *UTILITY_COMMANDS
        run_utility_command(formatted_input, stack)
      when 'q'
        break
      else
        result = Rpn.calculate(formatted_input, stack)
        puts "Result: #{result}" unless omit_results?(formatted_input, result)
      end
    rescue => e
      puts "Error: #{e.message}"
    end
  end
rescue EOFError, Interrupt
  puts "\nExiting... Goodbye!"
end
