def factors1(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end
p factors1(1)
p factors1(2)
# p factors1(0)

def factors2(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

puts "Using factors2"
p factors2(1)
p factors2(2)
p factors2(0)