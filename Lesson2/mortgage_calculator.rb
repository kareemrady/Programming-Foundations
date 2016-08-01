require 'yaml'
PROMPTS = YAML.load_file('mortgage_prompts.yml')

# Method for Prompts accepts a message
def prompt(message)
  puts PROMPTS[message]
end

# Method To find if an input is a valid number that is greater than 0
def not_a_valid_number?(number)
  num_regex = /^[1-9]+/
  num_regex.match(number).nil?
end

# Method to Calculate Monthly Intereste Rate
def calculate_monthly_interest_rate
  prompt('APR')
  apr = gets.chomp
  while not_a_valid_number?(apr)
    prompt('not_a_number')
    prompt('APR')
    apr = gets.chomp
  end
  (apr.to_f / 12.0) / 100
end

# Method to Calculate Loan Duration in Months
def calculate_loan_duration_months
  prompt('loan_duration')
  yearly_duration = gets.chomp
  while not_a_valid_number?(yearly_duration)
    prompt('not_a_number')
    prompt('loan_duration')
    yearly_duration = gets.chomp
  end
  yearly_duration.to_f * 12.0
end

def loan_amount_input
  prompt('loan_amount')
  loan = gets.chomp
  while not_a_valid_number?(loan)
    prompt('not_a_number')
    prompt('loan_amount')
    loan = gets.chomp
  end
  loan.to_f
end

def calculate_monthly_payment(amount, interest, duration)
  amount * (interest / (1 - (1 + interest)**-duration))
end

def quit
  prompt('quit')
  gets.chomp.capitalize
end

def mortgage_calculator
  quit_input = ''
  while quit_input != 'Q'
    prompt('welcome')
    monthly_rate = calculate_monthly_interest_rate
    duration_months = calculate_loan_duration_months
    amount = loan_amount_input
    payment = calculate_monthly_payment(amount, monthly_rate, duration_months)
    puts "Expected Monthly Payment is $#{payment.round(2)}"
    quit_input = quit
  end
end

mortgage_calculator
