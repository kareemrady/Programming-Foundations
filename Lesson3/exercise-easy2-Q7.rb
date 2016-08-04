advice = "Few things in life are as important as house training your pet dinosaur."

puts !advice.scan(/(Dino)/).empty?
puts !advice.match("Dino").nil?

puts advice.include?("Dino")

#using arrays

puts advice.split(" ").include?("Dino")