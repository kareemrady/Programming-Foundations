advice = "Few things in life are as important as house training your pet dinosaur."

# many ways

#using regex and sub method

using_sub = advice.gsub(/(important)/, 'urgent')
puts "Using sub method:  #{using_sub}"

# arrays
arr = advice.split(" ")
index = arr.find_index("important")
arr.insert(index, "urgent")
arr.delete("important")
using_arrays = arr.join(" ")
puts "Using Arrays:  #{using_arrays}"

#obvioulsy sub method is simpler