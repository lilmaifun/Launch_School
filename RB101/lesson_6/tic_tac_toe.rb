require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + 
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
FIRST_MOVE = 'choose'

def prompt(msg)
  puts "=> #{msg}"
end

def joiner(arr, delimiter=', ', end_marker='or')
  if arr.size == 0
    ''
  elsif arr.size == 1
    arr.first
  elsif arr.size == 2
    arr.join(" #{end_marker} ")
  else
    arr[-1] = "#{end_marker} #{arr.last}"
    arr.join(delimiter)
  end
end

def get_first_move
  if FIRST_MOVE == 'player'
    'player'
  elsif FIRST_MOVE == 'computer'
    'computer'
  else
    puts "\n"
    prompt "Who would you like to go first?"
    puts "\n"
    prompt "Press p for player and c for computer."
    puts "\n"
    answer = gets.chomp.downcase
    if answer == 'p'
      'player'
    elsif answer == 'c'
      'computer'
    end
  end
end

def place_piece!(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  elsif current_player == 'computer'
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  elsif current_player == 'computer'
    'player'
  end
end

def display_board(brd, scores)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  display_current_score(scores)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select{ |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joiner(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def square_at_immediate_threat(board)
  WINNING_LINES.each do |array|
    if board.values_at(*array).count(PLAYER_MARKER) == 2
      return array.select {|square| board[square] == INITIAL_MARKER}.first
    end
  end
  nil
end

def square_at_winning_spot(board)
  WINNING_LINES.each do |array|
    if board.values_at(*array).count(COMPUTER_MARKER) == 2
      return array.select {|square| board[square] == INITIAL_MARKER}.first
    end
  end
  nil
end

def computer_places_piece!(brd)
  random = empty_squares(brd).sample
  square_at_risk = square_at_immediate_threat(brd)
  square_at_winning = square_at_winning_spot(brd)

  if square_at_winning
    brd[square_at_winning] = COMPUTER_MARKER
  elsif square_at_risk
    brd[square_at_risk] = COMPUTER_MARKER
  elsif brd[5] == INITIAL_MARKER
    brd[5] = COMPUTER_MARKER
  else
    brd[random] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  if detect_winner(brd)
    return true
  end
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score(brd, scores)
  if detect_winner(brd) == 'Player'
    scores[:Player] += 1
  elsif detect_winner(brd) == 'Computer'
    scores[:Computer] += 1
  end
end

def display_current_score(scores)
  prompt "Player score: #{scores[:Player]} | Computer score: #{scores[:Computer]}"
end

def play_next_round
  prompt "Press any key to start next round."
  answer = gets.chomp
end

# -----------------------------actual game loop-----------------------------
loop do
  scores = Hash.new(0)

  loop do
    board = initialize_board
    current_player = get_first_move

    loop do
      display_board(board, scores)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      update_score(board, scores)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, scores)
  
    if someone_won?(board)
      prompt "#{detect_winner(board)} won this round!" unless (scores[:Player] == 5 || scores[:Computer] == 5)
    else
      prompt "It's a tie!"
    end

    if scores[:Player] == 5
      prompt "Congratulations! You won!"
      break
    elsif scores[:Computer] == 5
      prompt "Computer won!"
      break
    end

    play_next_round
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe!"

