require 'pry'
require 'pry-nav'

def is_not_a_number?(word)
  word.scan(/\d+$/).empty?
end

# p is_not_a_number?("192")
# p is_not_a_number?("02")
# p is_not_a_number?(".")


def dot_separated_ip_address?(input_string)
  # binding.pry
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4
  dot_separated_words.each do |word|
    return false if is_not_a_number?(word) 
  end
  true
end


p dot_separated_ip_address?("192.168")
p dot_separated_ip_address?("192.168.0.1")
p dot_separated_ip_address?("192")
p dot_separated_ip_address?("19+")
p dot_separated_ip_address?("19+.168.55.1")
p dot_separated_ip_address?("50.18.55.1")
p dot_separated_ip_address?("Hello World")