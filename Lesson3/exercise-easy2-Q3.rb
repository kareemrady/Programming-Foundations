ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

#method 1 using reject

ages.reject! { |_, v| v > 100  }
p ages


#method 2 using select or keep_if
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.select! { |_, v| v < 100 }