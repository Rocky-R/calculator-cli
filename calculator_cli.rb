Dir[File.join('.', 'modules', '*.rb')].each { |file| require file }

UTILITY_COMMANDS = %w[stack c module]
AVAILABLE_MODULES = %w[rpn standard]

class CalculatorCLI
  attr_accessor :stack, :current_module

  def initialize
    @stack = []
    @current_module = 'Rpn' # Set default module
  end

  def process_input(input)
    formatted_input = input.chomp.downcase

    case formatted_input
    when *AVAILABLE_MODULES
      self.current_module = format_module_name(formatted_input)
      "Module changed to: #{current_module}"
    when *UTILITY_COMMANDS
      run_utility_command(formatted_input)
    else
      begin
        calculator_module = Object.const_get(current_module)
        result = calculator_module.calculate(formatted_input, stack)
        omit_results?(formatted_input, result) ? nil : "Result: #{result}"
      rescue => e
        "Error: #{e.message}"
      end
    end
  end

  private

  def omit_results?(formatted_input, result)
    formatted_input.empty? || result.nil?
  end

  def format_module_name(name)
    name.split("_").map(&:capitalize).join
  end

  def run_utility_command(command)
    case command
    when 'c'
      stack.clear
      "Clearing stack"
    when 'stack'
      "Current stack: #{stack}"
    when 'module'
      "Current module is: #{current_module}"
    else
      "Invalid command: #{command}"
    end
  end
end

def run_cli
  cli = CalculatorCLI.new
  puts "Welcome to the Calculator CLI. The current calculator module is #{cli.current_module}",
       "To change modules, input the name of the desired module. Available modules are: #{AVAILABLE_MODULES.join(', ')}"

  loop do
    print "> "
    input = gets

    break if input.nil? || input.chomp.downcase == 'q'

    output = cli.process_input(input)

    puts output unless output.nil?
  end

  puts "\nExiting... Goodbye!"
end

run_cli if __FILE__ == $PROGRAM_NAME
