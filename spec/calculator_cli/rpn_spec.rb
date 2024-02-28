# frozen_string_literal: true

require_relative '../../lib/calculator/rpn'

RSpec.describe Rpn do
  describe '.calculate' do
    context 'with valid expressions' do
      it 'performs basic operations' do
        stack = []
        result = Rpn.calculate('3 4 +', stack)
        expect(result).to eq(7.0)
      end

      it 'handles multiple operations' do
        stack = []
        result = Rpn.calculate('5 5 5 8 + + -', stack)
        expect(result).to eq(-13.0)
      end

      it 'pushes result to the stack' do
        stack = []
        Rpn.calculate('3 4 +', stack)
        expect(stack).to eq([7.0])
      end

      context 'when no operators are present' do
        it 'pushes numbers to the stack' do
          stack = []
          Rpn.calculate('1 8 7', stack)
          expect(stack).to eq([1, 8, 7])
        end
      end

      context 'when stack contains previous results' do
        it 'performs operations with last stack value' do
          stack = [5, 6]
          result = Rpn.calculate('8 +', stack)
          expect(result).to eq(14)
        end

        context 'when an operator is provided without numbers' do
          it 'performs operation if at least 2 operands are present' do
            stack = [5, 6]
            result = Rpn.calculate('+', stack)
            expect(result).to eq(11)
          end
        end
      end
    end

    context 'with invalid tokens' do
      it 'raises an error for invalid tokens' do
        expect { Rpn.calculate('5 5 &', []) }.to raise_error(RuntimeError, 'Invalid token: &')
      end
    end

    context 'with insufficient operands' do
      it 'raises an error for insufficient operands' do
        expect { Rpn.calculate('3 +', []) }.to raise_error(RuntimeError, 'Insufficient operands')
      end
    end

    context 'when expression results in NaN' do
      it 'returns nothing' do
        stack = []
        result = Rpn.calculate('0 0 /', stack)
        expect(result).to be_nil
      end

      it 'does not push the result to the stack' do
        stack = []
        Rpn.calculate('0 0 /', stack)
        expect(stack).to be_empty
      end
    end
  end
end
