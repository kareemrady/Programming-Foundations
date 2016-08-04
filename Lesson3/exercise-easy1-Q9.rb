flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
barney = flintstones.select { |k,v| k == "Barney" }.flatten
p barney

p flintstones.assoc("Barney")
