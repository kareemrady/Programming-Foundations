munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

sum = 0

male_munsters = munsters.select { |k, v| v["gender"] == "male"}
p male_munsters
sum = 0
male_munsters.each {|k, v| sum+= v["age"] }
puts sum
