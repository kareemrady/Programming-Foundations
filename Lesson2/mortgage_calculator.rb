require 'yaml'
PROMPTS = YAML.load_file('mortgage_prompts.yml')

def prompt(message)
  puts PROMPTS[message]
end

def not_a_valid_number?(number)
  num_regex = /^[1-9]+/
  num_regex.match(number).nil?
end

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

def mortgage_calculator
  loop do
    prompt('welcome')
    monthly_rate = calculate_monthly_interest_rate
    duration_months = calculate_loan_duration_months
    amount = loan_amount_input
    payment = calculate_monthly_payment(amount, monthly_rate, duration_months)
    puts "Expected Monthly Payment is $#{payment.round(2)}"
    prompt('quit')
    break if gets.chomp.capitalize == 'Q'
  end
end

mortgage_calculator
