ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

#method1
sum = 0
ages.each_value { |v| sum += v }
puts sum

#method2  > reduce or inject
sum = ages.values.reduce(:+)
puts sum