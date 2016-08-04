flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones.each_with_index { |k, v| flintstones_hash[k] = v }
p flintstones_hash