# frozen_string_literal: true

require_relative '../lib/calculator.rb'

RSpec.describe CLI do
  let(:cli) { CLI.new }

  describe '#process_input' do
    context 'when input is a utility command' do
      it 'handles stack command' do
        expect(cli.process_input('stack')).to eq("Current stack: []")
      end

      it 'handles clear command' do
        cli.stack.push(5)
        expect(cli.process_input('c')).to eq("Clearing stack")
        expect(cli.stack).to be_empty
      end

      it 'handles module command' do
        expect(cli.process_input('module')).to eq("Current module is: Rpn")
      end
    end

    context 'when input is a module change command' do
      it 'changes module to Standard' do
        expect(cli.process_input('standard')).to eq("Module changed to: Standard")
        expect(cli.current_module).to eq('Standard')
      end

      it 'changes module to Rpn' do
        expect(cli.process_input('rpn')).to eq("Module changed to: Rpn")
        expect(cli.current_module).to eq('Rpn')
      end
    end

    context 'when input is an invalid command' do
      it 'returns an error message' do
        expect(cli.process_input('blah')).to include("Error:")
      end
    end
  end
end
