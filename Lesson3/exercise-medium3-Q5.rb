def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end


puts color_valid("blue")
puts color_valid("green")
puts color_valid("black")

def mod_color_valid(color)
  color == "blue" || color == "green"
end

puts mod_color_valid("blue")
puts mod_color_valid("green")
puts mod_color_valid("black")
