require "pry"

CARD_SUITS = [:Hearts, :Diamonds, :Clubs, :Spades].freeze
CARD_VALUES = (1..10).to_a
CARD_FACES = [:King, :Jack, :Queen].freeze
TWENTY_ONE = 21
FACE_VALUE = 10
ACE_VALUE = 11
DEALER_LIMIT = 17

def create_deck_of_cards
  deck = CARD_VALUES.product(CARD_SUITS) + CARD_FACES.product(CARD_SUITS)
  deck.shuffle
end

def player_pick_card(deck)
  deck.shift
end

def dealer_pick_card(deck)
  deck.shift
end

def hide_dealer_cards(dealer_cards)
  dealer_cards.last
end

def describe_card(card)
  if card.first == 1
    puts "Ace of #{card.last}"
  else
    puts "#{card.first} of #{card.last}"
  end
end

def compare_hands(player_hand, dealer_hand)
  player_score = calculate_score(player_hand)
  dealer_score = calculate_score(dealer_hand)
  if dealer_score < player_score
    return "Player Wins !!!"
  elsif dealer_score > player_score
    return "Dealer Wins!!!"
  else
    return "It's a Tie"
  end
end

def display_cards(cards, player = true, show_cards = true)
  if player && show_cards
    puts "\nPlayer's Hand\n-------------------------------------------------"
    cards.each { |card| describe_card(card) }
    puts "--------------------------------------------------------------"
  elsif show_cards && !player
    puts "\nDealer's Hand\n-------------------------------------------------"
    cards.each { |card| describe_card(card) }
    puts "----------------------------"
  else
    puts "\nDealer's Hand\n-------------------------------------------------"
    dealer_last_card = cards.last
    describe_card(dealer_last_card)
    puts "--------------------------------------------------------------"
  end
end

def initial_deal(deck)
  player_hand = []
  dealer_hand = []
  2.times { player_hand << player_pick_card(deck) }
  2.times { dealer_hand << dealer_pick_card(deck) }
  puts "\n-------------Cards After First Deal------------------------\n"
  display_cards(player_hand)
  display_cards(dealer_hand, false, false)
  [player_hand, dealer_hand]
end

def calculate_non_ace_cards(cards)
  total_score = 0
  cards.each do |card|
    total_score += CARD_FACES.include?(card) ? FACE_VALUE : card
  end
  total_score
end

def calculate_score(cards)
  total_score = 0
  cards_values = cards.map(&:first)
  if cards_values.include?(1)
    aces = cards_values.select { |card| card == 1 }
    other_cards = cards_values - aces
    total_score += calculate_non_ace_cards(other_cards)
    aces.each do
      total_score += (total_score + ACE_VALUE) <= TWENTY_ONE ? ACE_VALUE : 1
    end
  else
    total_score += calculate_non_ace_cards(cards_values)
  end
  total_score
end

def player_turn(deck, player_hand)
  player_hand << player_pick_card(deck)
  display_cards(player_hand)
end

def dealer_turn(deck, dealer_hand)
  dealer_hand << dealer_pick_card(deck)
  display_cards(dealer_hand, false, false)
end

def deal_or_stay_player
  puts "Please Type [Y] to deal card or [N] to stay"
  player_input = ''
  loop do
    player_input = gets.chomp.upcase
    break if ['Y', 'N'].include?(player_input)
    puts "Invalid Input , Please Type [Y] to deal card or [N] to stay"
  end
  player_input
end

def deal_or_stay_dealer?(score)
  if score < DEALER_LIMIT
    puts "\n=>Dealer Picks a Card\n"
    return true
  end
  puts "\n=>Dealer Stays\n"
  false
end

def busted?(score)
  score > TWENTY_ONE
end

def twenty_one?(score)
  score == TWENTY_ONE
end

def display_who_busted(p_score)
  if busted?(p_score)
    puts "Sorry you Busted!"
  else
    puts "You Win , Dealer Busted !!"
  end
end

def win_loss_message(p_score)
  if p_score == TWENTY_ONE
    puts "You Win !!"
  else
    puts "You lost better luck next time!"
  end
end

def dealer_hits(deck, d_cards, p_cards, d_score)
  loop do
    if deal_or_stay_dealer?(d_score)
      dealer_turn(deck, d_cards)
      d_score = calculate_score(d_cards)
      break if busted?(d_score) || twenty_one?(d_score)
    else
      puts "\n=>#{compare_hands(p_cards, d_cards)}\n"
      break
    end
  end
  d_score
end

def play_twenty_one(deck, p_cards, d_cards, p_score, d_score)
  player_response = deal_or_stay_player
  while player_response == 'Y' && !twenty_one?(p_score)
    puts "=>Player Picks a Card"
    player_turn(deck, p_cards)
    p_score = calculate_score(p_cards)
    display_cards(d_cards, false, false)
    break if busted?(p_score) || twenty_one?(p_score)
    puts "=>Player Score is now #{p_score}\n"
    player_response = deal_or_stay_player
  end
  if player_response == 'N'
    puts "\n=>Player Stays at #{p_score}\n"
    d_score = dealer_hits(deck, d_cards, p_cards, d_score)
  end
  { p_cards: p_cards, d_cards: d_cards, p_score: p_score, d_score: d_score }
end

def find_player_score(game_hash)
  game_hash[:p_score]
end

def find_dealer_score(game_hash)
  game_hash[:d_score]
end

def display_final_result(game_hash)
  puts "\n-------------------Final Result-----------------------------------\n"
  compare_cards_message = game_hash[:message]
  compare_cards_message unless compare_cards_message
  p_score = find_player_score(game_hash)
  d_score = find_dealer_score(game_hash)
  display_who_busted(p_score) if busted?(p_score) || busted?(d_score)
  win_loss_message(p_score) if twenty_one?(p_score) || twenty_one?(d_score)
  puts "Dealer Score is : #{d_score} & Player Score is : #{p_score}"
  display_cards(game_hash[:p_cards])
  display_cards(game_hash[:d_cards], false, true)
end

def play_game
  system 'clear'
  deck = create_deck_of_cards
  player_hand, dealer_hand = initial_deal(deck)
  player_score = calculate_score(player_hand)
  dealer_score = calculate_score(dealer_hand)
  game_play_hash = play_twenty_one(deck, player_hand,
                                   dealer_hand, player_score, dealer_score)
  display_final_result(game_play_hash)
end

play_game
