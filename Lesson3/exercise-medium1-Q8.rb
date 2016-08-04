def titelize1(title)
#using strings
title.gsub(/\b\w/) { |match| match.capitalize}
end

puts titelize1("its a small world")

def titelize2(title)
  title.split.map { |word| word.capitalize }.join(" ")
end
puts titelize2("the world is not enough")