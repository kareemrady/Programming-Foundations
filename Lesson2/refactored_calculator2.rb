def prompt(message)
  puts message
end

def input_not_a_number?(input)
  num_regex = %r{\d}
  num_regex.match(input).nil?
end

def input_not_an_operator?(input)
  op_regex = %r{[-+\/*%]}
  op_regex.match(input).nil?
end

def get_num_input(message)
  prompt message
  user_input = gets.chomp
  while input_not_a_number?(user_input)
    prompt 'Error Please type in a number ex 1, 2, 3.5'
    user_input = gets.chomp
  end
  user_input.to_f
end

def get_operator(message)
  prompt message
  user_input = gets.chomp
  while input_not_an_operator?(user_input)
    prompt message
    user_input = gets.chomp
  end
  user_input.to_sym
end

def start_calculator
  quit = ''
  while quit.capitalize != 'Q'
    prompt 'Welcome to My Simple Calculator'
    num1 = get_num_input('Please type in a number Ex: 1, 2, 3.5')
    num2 = get_num_input('Please type in a 2nd number Ex: 1, 2, 3.5')
    operation = get_operator('Please type in an operation to be performed "+", "-", "*", "/" or "%"')
    while num2 == 0.0 && operation == :/
      prompt 'Division by Zero is not allowed'
      num2 = get_num_input('Please type in a 2nd number Ex: 1, 2, 3.5')
    end
    result = num1.send(operation, num2)
    format("%.2f", result)
    prompt 'Type "q" or "Q" at to quit or press any other key to continue....'
    quit = gets.chomp
  end
  prompt 'Thanks for using my Calculator, Good Bye!!'
end

start_calculator
