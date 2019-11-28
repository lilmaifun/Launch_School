require 'pry'

SUITS = ['S', 'C', 'D', 'H']
CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']

def initialize_deck
  SUITS.product(CARD_VALUES).shuffle
end

def total(hand)
  values = hand.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'ace'
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value
    end
  end

  num_of_aces = values.select do |value|
    value == 'ace'
  end.count

  if sum > 21
    sum -= num_of_aces * 10
  end

  sum
end

def who_won(player_total, dealer_total)
  if (player_total > dealer_total) && (player_total <= 21) ||
     (dealer_total > 21 && player_total <= 21)
    player_total
  elsif ((dealer_total > player_total) && (dealer_total <= 21)) ||
        (player_total > 21 && dealer_total <= 21)
    dealer_total
  end
end

def display_results(player_total, dealer_total)
  if who_won(player_total, dealer_total) == player_total
    puts "Player won!"
  elsif who_won(player_total, dealer_total) == dealer_total
    puts "Dealer won!"
  else
    puts "It's a tie!"
  end
end

def busted?(total)
  total > 21
end

def play_again?(dealer_hand, player_hand, dealer_total, player_total)
  puts "======================================================================"
  puts "Dealer has #{dealer_hand}, and a total of #{dealer_total}."
  puts "Player has #{player_hand}, and a total of #{player_total}."
  puts "======================================================================"
  display_results(player_total, dealer_total)
  puts "Do you want to play again? (y or n)"
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

def score_update(player_total, dealer_total, scores)
  if who_won(player_total, dealer_total) == player_total
    scores[:Player] += 1
  elsif who_won(player_total, dealer_total) == dealer_total
    scores[:Dealer] += 1
  end
end

def display_score(scores)
  puts ""
  puts "^^^^^^Current Score^^^^^^"
  puts "Player: #{scores[:Player]} | Dealer: #{scores[:Dealer]}"
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^"
end

# ----------main game loop----------
loop do
  puts ""
  puts "          Welcome to Twenty-One!           "
  puts ""

  deck = initialize_deck
  scores = Hash.new(0)

  # whoever wins 5 rounds first wins entire game
  loop do
    player_hand = []
    dealer_hand = []

    # initial deal
    puts "======INITIAL DEAL======"
    2.times do
      player_hand << deck.pop
      dealer_hand << deck.pop
    end

    player_total = total(player_hand)
    dealer_total = total(dealer_hand)

    puts "Dealer has #{dealer_hand[0]} and ???"
    puts "You have: #{player_hand[0]} and #{player_hand[1]}."
    puts "Your total: #{player_total}"
    puts "======INITIAL DEAL======"
    puts ""

    # player turn
    puts ""
    puts "======> PLAYER'S TURN <======"
    loop do
      player_answer = nil
      loop do
        puts "hit or stay?"
        puts "press h for hit or s for stay"
        player_answer = gets.chomp.downcase
        break if ['s', 'h'].include?(player_answer)
        puts "Sorry, please choose h(it) or s(tay)."
      end

      if player_answer == 'h'
        player_hand << deck.pop
        player_total = total(player_hand)
        puts "Your hand is now: #{player_hand}"
        puts "Your total is now: #{player_total}"
      end

      break if player_answer == 's' || busted?(player_total)
    end

    if busted?(player_total)
      puts 'You busted!'
      score_update(player_total, dealer_total, scores)
      display_score(scores)
      play_again?(dealer_hand, player_hand, dealer_total, player_total) ? next : break
    else
      puts "You stayed at total: #{player_total}"
    end
    puts "======> END OF PLAYER'S TURN <======"
    puts ""

    # dealer turn
    puts ""
    puts "======> DEALER'S TURN <======"
    loop do
      break if dealer_total >= 17

      puts "Dealer hits!"
      dealer_hand << deck.pop
      dealer_total = total(dealer_hand)
      puts "Dealer's cards are now: #{dealer_hand}"
    end

    if busted?(dealer_total)
      puts "Dealer total is now: #{dealer_total}"
      puts "Dealer busted!"
      score_update(player_total, dealer_total, scores)
      display_score(scores)
      play_again?(dealer_hand, player_hand, dealer_total, player_total) ? next : break
    else
      puts "Dealer stays at #{dealer_total}"
    end

    puts "======> END OF DEALER'S TURN <======"
    puts ""

    # Both player and dealer stays - compare cards

    score_update(player_total, dealer_total, scores)
    display_score(scores)

    if scores[:Player] == 5 || scores[:Dealer] == 5
      puts "======================================================================"
      puts "Dealer has #{dealer_hand}, and a total of #{dealer_total}."
      puts "Player has #{player_hand}, and a total of #{player_total}."
      puts "======================================================================"
      puts ""
      puts ""
      puts "-----------------------------> GAME OVER <-----------------------------"
      puts ""
      puts ""
      if scores[:Player] == 5
        puts "Player is the grand winner!"
      elsif scores[:Dealer] == 5
        puts "Dealer is the grand winner!"
        puts ""
      end
    end

    break if scores[:Player] == 5 || scores[:Dealer] == 5

    break unless play_again?(dealer_hand, player_hand, dealer_total, player_total)
  end

  break
end

puts "****** THANKS FOR PLAYING TWENTY-ONE ******"
