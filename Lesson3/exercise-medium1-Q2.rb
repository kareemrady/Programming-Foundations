hash_count = {}
statement = "The Flintstones Rock"
#using_arrays
statement_char_arr = statement.split("")
statement_char_arr.each do |char|
  unless hash_count.keys.include?(char)
    hash_count[char] = statement_char_arr.count(char) 
  end
end

p hash_count

#LS Solution
hash_count = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |char|
  freq = statement.scan(char).count
  hash_count[char] = freq if freq > 0
end

p hash_count