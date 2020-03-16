require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset # Square.new is collaborator obj
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys # gives an array of keys that are yet to be marked
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  # relies on the truthiness of the returned obj
  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable ClassLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def vulnerable_square(player)
    square_to_fill = nil
    WINNING_LINES.each do |line|
      if values(line).count(player.marker) == 2
        line.each do |square|
          if @squares[square].marker == Square::INITIAL_MARKER
            square_to_fill = square
          end
        end
      end
    end
    square_to_fill
  end
end

#-----------------------------------------
# square class
class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

#-----------------------------------------
# player class
class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

#-------Game Orchestration Engine-------#
class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER.freeze

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new # collaborator object 1
    @human = Player.new(HUMAN_MARKER) # collaborator object 2
    @computer = Player.new(COMPUTER_MARKER) # collaborator object 3
    @current_marker = FIRST_TO_MOVE
    @score_board = {:human => 0, :computer => 0}
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      update_score
      display_results
      break if wins_5_games?
      break unless play_again?
      reset
      display_play_again_message
    end

    reset_score
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ''
    board.draw
    puts ''
  end

  def joinor(arr, delimiter = ', ', word = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(delimiter)
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = nil
    Board::WINNING_LINES.each do |line|
      square = board.find_at_risk_square(line, board)
      board[square] = computer.marker
      break if square
    end

    if square == nil
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def update_score
    if board.winning_marker == HUMAN_MARKER
      @score_board[:human] += 1
    elsif board.winning_marker == COMPUTER_MARKER
      @score_board[:computer] += 1
    end
  end

  def wins_5_games?
    @score_board[:human] == 5 || @score_board[:computer] == 5
  end

  def reset_score
    if @score_board[:human] == 5
      puts 'Congratulations, Player won!'
    else
      puts 'Computer won!'
    end
    @score_board = {:human => 0, :computer => 0}
  end

  def display_results
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts 'The board is full!'
    end

    puts "Player score: #{@score_board[:human]} | Computer score: #{@score_board[:computer]}"
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
