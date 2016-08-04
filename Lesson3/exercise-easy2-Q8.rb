flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
word_be =  flintstones.select { |word| word =~ /^Be/ }.join
p word_be
puts flintstones.index(word_be)

puts flintstones.index { |word| word =~ /^Be/}