def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"   #prints one two three as inside the method we are reassigning the variables so no change to the orifginal varaibles
puts "two is: #{two}"
puts "three is: #{three}" 

def mess_with_vars2(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars2(one, two, three) #same deal no change because we are reassigning the variables in the method thus creating a new variable

puts "one is: #{one}"
puts "two is: #{two}"
puts "three is: #{three}"

def mess_with_vars3(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars3(one, two, three)

puts "one is: #{one}" #the method calls gsub! which mutates the original string passed to the method
puts "two is: #{two}"
puts "three is: #{three}"