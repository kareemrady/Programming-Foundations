require 'securerandom'
def create_uuid
  SecureRandom.uuid
end

p create_uuid


# without module
def generate_hex_array
  hex_characters =[]
  (0..9).each do |char|
    hex_characters << char
  end
  ('a'..'f').each do |char|
    hex_characters << char
  end
  hex_characters
end

def pick_random_numbers(arr, sample_size)
  sample_arr = []
  sample_size.times do 
    sample_arr << arr.sample
  end
  sample_arr
end

p generate_hex_array

def generate_uuid
  uuid_string = ''
  hex_characters = generate_hex_array
  sections = [8, 4, 4, 4 , 12]
  (0..4).each do |index|
    uuid_string += pick_random_numbers(hex_characters, sections[index]).join + "-"
  end
  uuid_string.chop
end

p generate_uuid