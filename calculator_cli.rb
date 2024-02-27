Dir[File.join('.', 'modules', '*.rb')].each { |file| require file }

UTILITY_COMMANDS = %w[stack c module]
AVAILABLE_MODULES = %w[rpn standard]

def omit_results?(formatted_input, result)
  formatted_input.empty? || result.nil?
end

def format_module_name(name)
  name.split("_").map(&:capitalize).join
end

def run_utility_command(command, stack, current_module)
  case command
  when 'c'
    stack.clear
    puts "Clearing stack"
  when 'stack'
    puts "Current stack: #{stack}"
  when 'module'
    puts "Current module is: #{current_module}"
  else
    puts "Invalid command: #{command}"
  end
end

stack = []
first_iteration = true
current_module = 'Rpn'

begin
  loop do
    if first_iteration
      puts "Welcome to the Calculator CLI. The current calculator module is #{current_module}",
           "To change modules, input the name of the desired module. Available modules are: #{AVAILABLE_MODULES.join(', ')}"
      first_iteration = false
    end

    print "> "
    input = gets

    break if input.nil?

    formatted_input = input.chomp.downcase

    begin
      case formatted_input
      when *AVAILABLE_MODULES
        current_module = format_module_name(formatted_input)
        puts "Module changed to: #{current_module}"
      when *UTILITY_COMMANDS
        run_utility_command(formatted_input, stack, current_module)
      when 'q'
        break
      else
        calculator_module = Object.const_get(current_module)
        result = calculator_module.calculate(formatted_input, stack)
        puts "Result: #{result}" unless omit_results?(formatted_input, result)
      end
    rescue => e
      puts "Error: #{e.message}"
    end
  end
rescue EOFError, Interrupt
  puts "\nExiting... Goodbye!"
end
