# paper beats rock, rock beats scissors, scissors beats paper
require 'yaml'

MESSAGES = YAML.load_file('rps_messages.yml')
GAME_CHOICES = %w(rock paper scissors)
USER_SELECTION_HASH = { r: 'rock', p: 'paper', s: 'scissors' }
WINNING_OPTIONS = %w(rock scissors), %w(scissors paper), %w(paper rock)
#player selection is first item in each array representing a winning option
PLAYER_WINNING_OPTIONS = {player_wins: WINNING_OPTIONS}


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
    user_selection = gets.chomp.to_sym
    break if USER_SELECTION_HASH.keys.include?(user_selection)
    prompt('invalid_selection')
  end
  USER_SELECTION_HASH[user_selection]
end

def display_winner(player_Selection, computer_selection)
  choices = [player_Selection, computer_selection]
  player_winning_options_arr = PLAYER_WINNING_OPTIONS.values.flatten(1)
  if player_Selection == computer_selection
    prompt('tie')
  elsif player_winning_options_arr.include?(choices)
    prompt('user_wins') 
  else 
    prompt('user_lost')
  end
  puts "You Selected #{player_Selection.capitalize} & Computer Selected #{computer_selection.capitalize}"
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
