require 'yaml'

MESSAGES = YAML.load_file('rps_messages.yml')
GAME_CHOICES = %w(Rock Paper Scissors Spock Lizard)
USER_SELECTION_HASH = {
  r: 'Rock',
  p: 'Paper',
  l: 'Lizard',
  s1: 'Scissors',
  s2: 'Spock'
}
# player selection is first item in each array representing a winning option
WINNING_OPTIONS =
  %w(Rock Scissors),
  %w(Scissors Paper),
  %w(Paper Rock),
  %w(Rock Lizard),
  %w(Lizard Spock),
  %w(Spock Scissors),
  %w(Scissors Lizard),
  %w(Lizard Paper),
  %w(Paper Spock),
  %w(Spock Rock)

PLAYER_WINNING_OPTIONS = { player_wins: WINNING_OPTIONS }

def prompt(message)
  puts MESSAGES[message]
end

def computer_selected_choice
  GAME_CHOICES.sample
end

def scissors_spock_selection
  prompt('scissors_or_spock')
  selection_options = %w(1 2)
  selection = gets.chomp
  loop do
    break if selection_options.include?(selection)
    prompt('invalid_selection_s')
    selection = gets.chomp
  end
  's' + selection
end

def prompt_user_for_input
  prompt('user_selection')
  user_selection = ''
  loop do
    user_selection = gets.chomp.downcase
    user_selection = scissors_spock_selection if user_selection == 's'
    break if USER_SELECTION_HASH.keys.include?(user_selection.to_sym)
    prompt('invalid_selection')
  end
  USER_SELECTION_HASH[user_selection.to_sym]
end

def create_flag(player_selection, computer_selection)
  {
    player_win: 0,
    computer_win: 0,
    choices: [player_selection, computer_selection],
    tie: 0
  }
end

def find_winner(player_selection, computer_selection)
  flag = create_flag(player_selection, computer_selection)
  player_winning_options_arr = PLAYER_WINNING_OPTIONS.values.flatten(1)
  if flag[:choices][0] == flag[:choices][1]
    flag[:tie] = 1
  elsif player_winning_options_arr.include?(flag[:choices])
    flag[:player_win] = 1
  else
    flag[:computer_win] = 1
  end
  flag
end

def display_winner(flag)
  if flag[:player_win] == 1
    prompt('user_wins')
    puts "#{flag[:choices][0]} beats #{flag[:choices][1]}"
  elsif flag[:computer_win] == 1
    prompt('user_lost')
    puts "#{flag[:choices][1]} beats #{flag[:choices][0]}"
  else
    prompt('tie')
  end
end

def play_game
  user_choice = prompt_user_for_input
  computer_choice = computer_selected_choice
  winner = find_winner(user_choice, computer_choice)
  display_winner(winner)
  winner
end

def find_plural(num, word)
  num > 1 || num.zero? ? word + 's' : word
end

def display_score(scores_hash)
  player_score = scores_hash[:player]
  computer_score = scores_hash[:computer]
  ties = scores_hash[:ties]
  puts "Game Over !!"
  puts "------------------------------------------"
  puts "Player Won #{player_score} #{find_plural(player_score, 'time')}"
  puts "Computer Won #{computer_score} #{find_plural(computer_score, 'time')}"
  puts "Ties #{ties} #{find_plural(ties, 'time')}"
  puts "------------------------------------------"
end

def play_n_times(num)
  score_board = { player: 0, computer: 0, ties: 0 }
  num.times do
    winner = play_game
    score_board[:player] += winner[:player_win]
    score_board[:computer] += winner[:computer_win]
    score_board[:ties] += winner[:tie]
  end
  display_score(score_board)
end

play_n_times(5)
