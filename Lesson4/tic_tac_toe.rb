require 'yaml'

LETTER_OPTIONS = %w(X O).freeze
MESSAGES = YAML.load_file('tic_tac_toe_messages.yml')
SQUARE_COORDINATES = [0, 1, 2].product([0, 1, 2])
SQUARE_NUM_OPTIONS = (1..9).to_a

def board_map_generator
  board_map = {}
  (1..9).each do |num|
    board_map[num] = SQUARE_COORDINATES[num - 1]
  end
  board_map
end

def prompt(message)
  puts MESSAGES[message]
end

def display_square_board_numbers
  prompt "line"
  prompt "available_selections"
  message = 'square'
  (1..9).each do |num|
    square_num = message + num.to_s
    print MESSAGES[square_num]
    print "|\n" if (num % 3).zero?
  end
end

def display_empty_board
  3.times do
    puts MESSAGES["empty_square"] * 4
  end
end

def display_selections(p_selections, c_selections, p_letter, c_letter)
  prompt "line"
  message_empty = 'empty_square'
  message_selected = 'square_'
  player_coords = p_selections.keys
  comp_coords = c_selections.keys
  player_message = message_selected + p_letter
  comp_message = message_selected + c_letter
  (1..9).each do |num|
    case 
    when player_coords.include?(num)
      print MESSAGES[player_message]
    when comp_coords.include?(num)
      print MESSAGES[comp_message]
    else 
      print MESSAGES[message_empty]      
    end
    print "|\n" if (num % 3).zero?
  end
end

def display_current_board(options = {})
  prompt "current_board"
  p_choices = options[:p_choices]
  c_choices = options[:c_choices]
  p_letter = options[:p_letter]
  c_letter = options[:c_letter] 
  if options.empty?
    display_empty_board
    display_square_board_numbers
  else
    display_selections(p_choices, c_choices, p_letter, c_letter)
  end
end

def choose_letter_player
  prompt "letter"
  letter = ''
  loop do
    letter = gets.chomp.capitalize
    break if LETTER_OPTIONS.include?(letter)
    prompt "invalid_letter_selection"
  end
  letter
end

def choose_letter_computer(player_selection)
  LETTER_OPTIONS.select { |l| l != player_selection }[0]
end

def player_select_square(selections_hash)
  prompt "player_turn"
  player_selection = ''
  loop do
    player_selection = gets.chomp.to_i
    break if selections_hash.key?(player_selection)
    prompt "invalid_map_selection"
  end
  selections_hash.select { |k, _| k == player_selection }
end

def computer_select_square(selections_hash)
  computer_selection = nil
  loop do
    computer_selection = SQUARE_NUM_OPTIONS.sample
    break if selections_hash.key?(computer_selection)
  end
  selections_hash.select { |k, _| k == computer_selection }
end

def play_game
  prompt "welcome"
  player_selections = {}
  computer_selections = {}
  board_map = board_map_generator
  player_letter = choose_letter_player
  computer_letter = choose_letter_computer(player_letter)
  display_current_board
  player_selection = player_select_square(board_map)
  board_map.delete_if { |k, _| k == player_selection.keys[0]}
  player_selections.merge!(player_selection)
  computer_selection = computer_select_square(board_map)
  computer_selections.merge!(computer_selection)
  board_map.delete_if { |k, _| k == computer_selection.keys[0]}
  p player_selections
  p computer_selections
  p board_map
  display_current_board(p_choices: player_selections,c_choices: computer_selections,p_letter: player_letter,c_letter: computer_letter)
end

play_game
