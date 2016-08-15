CARD_SUITS = [:Hearts, :Diamonds, :Clubs, :Spades].freeze
CARD_VALUES = (1..10).to_a
CARD_FACES = [:King, :Jack, :Queen].freeze
ACE = 1
TWENTY_ONE = 21
FACE_VALUE = 10
ACE_VALUE = 11

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
  return player_hand, dealer_hand
end

def calculate_non_ace_cards(cards)
  total_score = 0
  cards.each do |card|
    if CARD_FACES.include?(card)
      total_score += FACE_VALUE
    else
      total_score += card
    end
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

def deal_or_hold_player
  puts "Please Type [Y] to deal card or [N] to hold"
  player_input = ''
  loop do
    player_input = gets.chomp.upcase
    break if ['Y', 'N'].include?(player_input)
    puts "Invalid Input , Please Type [Y] to deal card or [N] to hold"
  end
  player_input
end

def deal_or_hold_dealer?(score)
  if score < 17
    puts "\nDealer picks a card"
    return true
  end
  puts "\n Dealer Stays"
  false
end

def busted?(score)
  score > 21
end

def twenty_one?(score)
  score == 21
end

def display_who_busted(p_score)
  if busted?(p_score)
    puts "Sorry you Busted!"
  else
    puts "You Win , Dealer Busted"
  end
end

def win_loss_message(p_score)
  if p_score == 21
    puts "You Win !!"
  else
    puts "You lost better luck next time!"
  end
end

def play_twenty_one(deck, p_cards, d_cards, p_score, d_score)
  loop do
    player_deal_response = deal_or_hold_player
    if player_deal_response == 'Y'
      player_turn(deck, p_cards)
      p_score = calculate_score(p_cards)
      break if busted?(p_score) || twenty_one?(p_score)
    end
    dealer_turn(deck, d_cards) if deal_or_hold_dealer?(d_score)
    display_cards(d_cards, false, false)
    d_score = calculate_score(d_cards)
    break if busted?(d_score) || twenty_one?(d_score)
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
  p_score = find_player_score(game_hash)
  d_score = find_dealer_score(game_hash)
  display_who_busted(p_score) if busted?(p_score) || busted?(d_score)
  win_loss_message(p_score) if twenty_one?(p_score) || twenty_one?(d_score)
  puts "Dealer Score is : #{d_score} & Player Score is : #{p_score}"
end

def play_game
  deck = create_deck_of_cards
  player_hand, dealer_hand = initial_deal(deck)
  player_score = calculate_score(player_hand)
  dealer_score = calculate_score(dealer_hand)
  game_play_hash = play_twenty_one(deck, player_hand,
                                   dealer_hand, player_score, dealer_score)
  display_final_result(game_play_hash)
  display_cards(dealer_hand, false, true)
  display_cards(player_hand)
end

play_game
