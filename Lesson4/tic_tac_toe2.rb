require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('tic_tac_toe_messages.yml')
BLANK_MK = ' '
PLAYER_MK = 'X'
COMP_MK = 'O'
WINNING_KEYS = [
  [1, 2, 3], [4, 5, 6],
  [7, 8, 9], [1, 4, 7],
  [2, 5, 8], [3, 6, 9],
  [1, 5, 9], [3, 5, 7]
].freeze

def display_board(brd)
  # system "clear"
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
   puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end

def prompt(message)
  puts "#{message}"
end

def joinor(arr, delimiter = ',', word = 'or')
 arr[-1] = "#{word} #{arr.last}" if arr.size > 1
 arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
end

puts joinor([1,2,3])
puts joinor([1,2,3], ";")
puts joinor([1,2,3], ",", "and")

def initialize_board
  board_map = {}
  (1..9).each {|num| board_map[num] = BLANK_MK }
  board_map
end

def empty_squares(board)
  board.keys.select{ |num| board[num] == BLANK_MK }
end

def player_places_piece!(board)
  prompt "Please choose a square (#{joinor(empty_squares(board))}):"
  square = ''
  loop do
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt "Invalid Choice, choose a square (#{joinor(empty_squares(board))}):"
  end
  board[square] = PLAYER_MK
end

def computer_places_piece!(board)
  computer_selection = empty_squares(board).sample
  board[computer_selection] = COMP_MK
end

def board_full?(board)
  empty_squares(board).empty?
end

def find_player_selections(board)
  board.select { |k, v| v  == 'X'}.keys
end

def find_computer_selections(board)
  board.select { |k, v| v  == 'O'}.keys
end

def find_all_combinations(selection)
  selection.sort.combination(3).to_a
end

def find_winner(board)
  player_selections = find_player_selections(board)
  comp_selections = find_computer_selections(board)
  if find_all_combinations(player_selections).any? { |selection| WINNING_KEYS.include?(selection)} 
    return "Player"
  elsif find_all_combinations(comp_selections).any? { |selection| WINNING_KEYS.include?(selection)}
    return "Computer"
  end
  nil
end

def find_at_risk_square(line, board, marker)
  find_all_combinations(player_selections).any? { |selection| WINNING_KEYS - selection }
end

def someone_won?(board)
  !!find_winner(board)
end

def play_game(board)
  loop do
      display_board(board)
      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
      display_board(board)
      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end
    display_board(board)
end

def play_best_of_five
  scores = {p_score: 0, c_score: 0, ties: 0} 
  ties = 0
  loop do
    board = initialize_board
    play_game(board)
    if someone_won?(board)
      puts "#{find_winner(board)} Won!!"
      find_winner(board) == 'Player' ? scores[:p_score] += 1 : scores[:c_score] += 1
    else
      puts "It's a tie"
      scores[:ties] += 1
    end
    break if scores.values.any? {|score| score == 5 }
  end
end


play_best_of_five

