advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.slice!(0...advice.index("house"))
puts advice

#slice will need to store everything as variables because it doesn't mutate the string