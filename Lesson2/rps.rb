require 'yaml'

MESSAGES = YAML.load_file('rps_messages.yml')
GAME_CHOICES = %w(Rock Paper Scissors)
USER_SELECTION_HASH = { r: 'Rock', p: 'Paper', s: 'Scissors' }
WINNING_OPTIONS = %w(Rock Scissors), %w(Scissors Paper), %w(Paper Rock)
# player selection is first item in each array representing a winning option
PLAYER_WINNING_OPTIONS = { player_wins: WINNING_OPTIONS }

def prompt(message)
  puts MESSAGES[message]
end

def computer_selected_choice
  GAME_CHOICES.sample
end

def prompt_user_for_input
  prompt('user_selection')
  user_selection = ''
  loop do
    user_selection = gets.chomp.downcase.to_sym
    break if USER_SELECTION_HASH.keys.include?(user_selection)
    prompt('invalid_selection')
  end
  USER_SELECTION_HASH[user_selection]
end

def display_winner(player_selection, computer_selection)
  choices = [player_selection, computer_selection]
  player_winning_options_arr = PLAYER_WINNING_OPTIONS.values.flatten(1)
  if player_selection == computer_selection
    prompt('tie')
  elsif player_winning_options_arr.include?(choices)
    prompt('user_wins')
  else
    prompt('user_lost')
  end
  puts "You chose #{player_selection} & Computer chose #{computer_selection}"
end

def play_game
  loop do
    prompt('welcome')
    user_choice = prompt_user_for_input
    computer_choice = computer_selected_choice
    display_winner(user_choice, computer_choice)
    prompt('quit')
    quit = gets.chomp.downcase
    break if quit == 'q'
  end
end

play_game
