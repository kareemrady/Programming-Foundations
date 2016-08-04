def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

puts "Using Rolling Buffer one method shift operator"
p buffer1 = [1,2,3]
rolling_buffer1(buffer1, 3, 5)
p buffer1

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

puts "Using Rolling Buffer two method Adding array"
p buffer2 = [1,2,3]
rolling_buffer2(buffer1, 3, 5)
p buffer2
