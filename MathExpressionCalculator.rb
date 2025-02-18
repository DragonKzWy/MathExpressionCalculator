class MathExpressionCalculator
  OPERATORS = {
    "^" => { precedence: 3, associativity: :right },
    "*" => { precedence: 2, associativity: :left },
    "/" => { precedence: 2, associativity: :left },
    "+" => { precedence: 1, associativity: :left },
    "-" => { precedence: 1, associativity: :left }
  }

  def initialize(expression)
    @expression = expression.gsub(/\s+/, "") # Remove spaces
  end

  def calculate
    begin
      tokens = tokenize(@expression)
      puts "Tokens: #{tokens.inspect}" # Debugging output
      validate_tokens(tokens)
      rpn = shunting_yard(tokens)
      evaluate_rpn(rpn)
    rescue StandardError => e
      "Error: #{e.message}"
    end
  end

  private

  # Tokenizes the input correctly
  def tokenize(expression)
    tokens = expression.scan(/(?:\d+\.\d+|\d+|[\+\-\*\/\^\(\)])/)
    tokens.map(&:to_s) # Ensures they are strings
  end

  # Converts to Reverse Polish Notation (Shunting-Yard Algorithm)
  def shunting_yard(tokens)
    output_queue = []
    operator_stack = []

    tokens.each do |token|
      if number?(token)
        output_queue << token.to_f
      elsif operator?(token)
        while !operator_stack.empty? && operator_stack.last != "(" &&
              higher_precedence?(operator_stack.last, token)
          output_queue << operator_stack.pop
        end
        operator_stack << token
      elsif token == "("
        operator_stack << token
      elsif token == ")"
        while !operator_stack.empty? && operator_stack.last != "("
          output_queue << operator_stack.pop
        end
        raise "Mismatched parentheses" if operator_stack.empty?
        operator_stack.pop # Remove "("
      end
    end

    while !operator_stack.empty?
      raise "Mismatched parentheses" if operator_stack.last == "("
      output_queue << operator_stack.pop
    end

    output_queue
  end

  # Evaluates the RPN expression
  def evaluate_rpn(rpn)
    stack = []

    rpn.each do |token|
      if token.is_a?(Float)
        stack << token
      else
        raise "Invalid expression" if stack.size < 2
        b, a = stack.pop(2)
        raise "Division by zero" if token == "/" && b == 0
        stack << apply_operator(a, b, token)
      end
    end

    raise "Invalid expression" unless stack.size == 1
    stack.pop.round(6)
  end

  # Validates the tokens
  def validate_tokens(tokens)
    raise "Empty expression" if tokens.empty?

    invalid_tokens = tokens.reject { |t| number?(t) || operator?(t) || ["(", ")"].include?(t) }

    unless invalid_tokens.empty?
      raise "Invalid characters in expression: #{invalid_tokens.join(", ")}"
    end
  end

  # Helper methods
  def number?(token)
    token.match?(/^\d+(\.\d+)?$/)
  end

  def operator?(token)
    OPERATORS.key?(token)
  end

  def higher_precedence?(op1, op2)
    op1_data = OPERATORS[op1]
    op2_data = OPERATORS[op2]
    return false if op1_data.nil? || op2_data.nil?

    if op1_data[:precedence] > op2_data[:precedence]
      true
    elsif op1_data[:precedence] == op2_data[:precedence]
      op1_data[:associativity] == :left
    else
      false
    end
  end

  def apply_operator(a, b, operator)
    case operator
    when "+" then a + b
    when "-" then a - b
    when "*" then a * b
    when "/" then a / b
    when "^" then a**b
    end
  end
end

# Program execution
puts "Enter a mathematical expression:"
expression = gets.chomp
calculator = MathExpressionCalculator.new(expression)
puts "Result: #{calculator.calculate}"
