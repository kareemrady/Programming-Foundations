# Refactored with Functions and error handling
# gets user input and ensures it is a number
def get_number_input(message)
  puts message
  begin
    num = gets.chomp
    num_regex = %r{\d}
    raise TypeError.new("Invalid Number #{num} please input a valid number ex 1 , 2, 3.5, ...") if num_regex.match(num).nil?
  rescue TypeError => e
    puts e.message
    num = get_number_input(message)
  end
  num.to_f
end

def get_operation_input(message)
  puts message
  begin
    operation = gets.chomp
    op_regex = %r{[-+*\/%]}
    # raise an error if the regex doesn't match one of the allowed operations or if there is a typo ++ , -+ more than one operator entered
    raise ArgumentError.new("Invalid Entry #{operation} please type + - * / or %") if op_regex.match(operation).nil? || operation.size > 1
  rescue ArgumentError => e
    puts e.message
    operation = get_operation_input(message)
  end
  operation.to_sym
end

def start_calculator
  begin
    num1 = get_number_input("Please type a number : ")
    num2 = get_number_input("Please type a 2nd number : ")
    operation = get_operation_input("Please type in an operation + - / * %")
    raise ZeroDivisionError.new("Cannot Divide by Zero") if operation == :/ && num2 == 0.0
  rescue ZeroDivisionError => e
    puts e.message
    num2 = get_number_input("Please type a 2nd number : ")
  end
  num1.send(operation, num2)
end
puts start_calculator
