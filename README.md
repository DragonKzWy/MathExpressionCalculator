# Math Expression Calculator

A simple mathematical expression calculator written in Ruby. This application evaluates user-inputted mathematical expressions while supporting operators, parentheses, exponentiation, and decimal numbers. It also includes error handling for invalid input.

## Features

- Supports addition (`+`), subtraction (`-`), multiplication (`*`), division (`/`), and exponentiation (`^`).
- Handles expressions with parentheses (`( )`).
- Supports decimal numbers.
- Implements the **Shunting-Yard Algorithm** for operator precedence.
- Converts expressions to **Reverse Polish Notation (RPN)** for evaluation.
- Provides error handling for invalid expressions, mismatched parentheses, and division by zero.

## Installation

Ensure you have **Ruby** installed on your system. If not, install it from [ruby-lang.org](https://www.ruby-lang.org/).

1. Clone this repository:
   ```sh
   git clone https://github.com/DragonKzWy/MathExpressionCalculator.git
   ```
2. Navigate to the project folder:
   ```sh
   cd MathExpressionCalculator
   ```
3. Run the application:
   ```sh
   MathExpressionCalculator.rb
   ```

## Usage

Run the script and enter a mathematical expression when prompted:
```sh
Enter a mathematical expression:
2 + 3 * (4 ^ 2)
```
Output:
```sh
Result: 50.0
```

## Example Expressions

| Expression        | Result |
|------------------|--------|
| `3 + 5 * 2`      | 13     |
| `(10 / 2) + 4`   | 9      |
| `2 ^ 3`          | 8      |
| `5.5 * 2`        | 11.0   |
| `10 / (5 - 5)`   | Error: Division by zero |

## Error Handling

The calculator detects and reports errors such as:
- Invalid characters in the input.
- Mismatched parentheses.
- Division by zero.
- Empty expressions.

## License

This project is licensed under the **MIT License**. Feel free to use and modify it as needed.

## Contributions

Contributions are welcome! Feel free to submit issues or pull requests.

## Author

Created by **Wesley**. Connect with me on [GitHub](https://github.com/DragonKzWy).

