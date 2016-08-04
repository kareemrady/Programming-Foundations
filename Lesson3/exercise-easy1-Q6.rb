famous_words = "seven years ago..."
famous_words.prepend("Four score and ") #method 1
puts famous_words
famous_words = "seven years ago..."
famous_words.sub!(//, "Four score and " ) 
puts famous_words
famous_words = "seven years ago..."
puts "Four score and " + famous_words

