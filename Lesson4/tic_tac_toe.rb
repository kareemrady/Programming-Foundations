require 'yaml'

LETTER_OPTIONS = %w(X O).freeze
MESSAGES = YAML.load_file('tic_tac_toe_messages.yml')
SQUARE_COORDINATES = [0, 1, 2].product([0, 1, 2])
SQUARE_NUM_OPTIONS = (1..9).to_a
WINNING_KEYS = [
  [1, 2, 3], [4, 5, 6],
  [7, 8, 9], [1, 4, 7],
  [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
] 

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

def display_square_board
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
  message_selected = 'square_'
  player_message = message_selected + p_letter
  comp_message = message_selected + c_letter
  (1..9).each do |num|
    if p_selections.keys.include?(num)
      print MESSAGES[player_message]
    elsif c_selections.keys.include?(num)
      print MESSAGES[comp_message]
    else
      print MESSAGES['empty_square']
    end
    print "|\n" if (num % 3).zero?
  end
end

def display_square_selections(options = {})
  p_choices = options[:p_choices]
  c_choices = options[:c_choices]
  message = 'square'
  if options.empty?
    display_square_board
  else
    prompt "line"
    prompt "available_selections"
    (1..9).each do |num|
      if p_choices.keys.include?(num) || c_choices.keys.include?(num)
        square_na = message + "_NA"
        print MESSAGES[square_na]
      else
        square_num = message + num.to_s
        print MESSAGES[square_num]
      end
      print "|\n" if (num % 3).zero?
    end
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
    display_square_board
  else
    display_selections(p_choices, c_choices, p_letter, c_letter)
    display_square_selections(p_choices: p_choices, c_choices: c_choices)
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
    break if selections_hash.key?(player_selection) || selections_hash.empty?
    prompt "invalid_map_selection"
  end
  selections_hash.select { |k, _| k == player_selection }
end

def computer_select_square(selections_hash)
  computer_selection = nil
  loop do
    computer_selection = SQUARE_NUM_OPTIONS.sample
    break if selections_hash.key?(computer_selection) || selections_hash.empty?
  end
  selections_hash.select { |k, _| k == computer_selection }
end

def generate_hash(p_choices, c_choices, p_letter, c_letter)
  {
    p_choices: p_choices,
    c_choices: c_choices,
    p_letter: p_letter,
    c_letter: c_letter
  }
end

def delete_selection(board_hash, selection_hash)
  board_hash.delete_if { |k, _| k == selection_hash.keys[0] }
end

def player_turn(board_map, letter, p_choices)
  p_selection = player_select_square(board_map)
  delete_selection(board_map, p_selection)
  p_choices.merge!(p_selection)
end

def computer_turn(board_map, letter, c_choices)
  c_selection = computer_select_square(board_map)
  delete_selection(board_map, c_selection)
  c_choices.merge!(c_selection)
end

def winner_found?(p_selections, c_selections)
  if WINNING_KEYS.flatten.include?(p_selections.keys)
    puts "Player Wins"
    return true
  elsif WINNING_KEYS.flatten.include?(c_selections.keys)
    puts "Computer Wins"
    return true
  else
    return false
  end
end

def play_game
  prompt "welcome"
  p_selections = {}
  c_selections = {}
  board_map = board_map_generator
  p_letter = choose_letter_player
  c_letter = choose_letter_computer(p_letter)
  display_current_board
  9.times do
    break if board_map.empty?
    player_turn(board_map, p_letter, p_selections)
    computer_turn(board_map, c_letter, c_selections)
    board_hash = generate_hash(p_selections, c_selections, p_letter, c_letter)
    winner = winner_found?(p_selections, c_selections)
    break if winner
    display_current_board(board_hash)
  end
  puts "GoodBye!!"
end

play_game
