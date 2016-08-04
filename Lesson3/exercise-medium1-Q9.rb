munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def find_age_group(age)
  age_group = case age
    when 0..17 then "kid"
    when 18..64 then "adult"
    else 
      "senior"
  end
end

munsters.each_value do |hash|
  age_group = find_age_group(hash["age"])
  hash["age_group"] = age_group
end

p munsters
