require 'pry'

class Move
  VALUES = %w(rock paper scissors spock lizard)

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Scissors < Move
  def >(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end

  def <(other_move)
    other_move.class == Rock || other_move.class == Spock
  end
end

class Rock < Move
  def >(other_move)
    other_move.class == Scissors || other_move.class == Lizard
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Spock
  end
end

class Paper < Move
  def >(other_move)
    other_move.class == Rock || other_move.class == Spock
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Lizard
  end
end

class Spock < Move
  def >(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end
end

class Lizard < Move
  def >(other_move)
    other_move.class == Paper || other_move.class == Spock
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end
end

#-------

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end

  def update_score
    self.score += 1
  end
end

#-------

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    value = nil
    loop do
      puts 'Please choose rock, paper, scissors, spock, or lizard:'
      value = gets.chomp
      break if Move::VALUES.include?(value)
      puts 'Sorry, invalid value.'
    end
    self.move = case value
                  when 'rock' 
                    Rock.new(value)
                  when 'paper' 
                    Paper.new(value)
                  when 'scissors' 
                    Scissors.new(value)
                  when 'spock' 
                    Spock.new(value)
                  when 'lizard' 
                    Lizard.new(value)
                end
    @history << value
  end
end

#--------
class R2D2 < Player
  def set_name
    self.name = 'R2D2'
  end

  def choose
    self.move = Rock.new('rock')
    @history << 'rock'
  end
end

class Hal < Player #mostly chooses scissors, rarely rock, and never paper
  def set_name
    self.name = 'Hal'
  end

  def choose
    choices = %w(rock scissors spock lizard)
    choices.fill('scissors', 4, 5).fill(%w(spock lizard), 9, 2).flatten!
    self.move = choices.sample
  end
end

class Chappie < Player #never chooses rock or lizard
  def set_name
    self.name = 'Chappie'
  end

  def choose
    choices = %w(scissors spock)
    self.move = choices.sample
  end
end

class Sonny < Player #mostly chooses spock but rarely lizard
  def set_name
    self.name = 'Sonny'
  end

  def choose
    choices = %w(rock paper scissors spock lizard)
    choices.fill('spock', 5, 6).fill(%w(rock paper scissors), 11, 3).flatten!
    self.move = choices.sample
  end
end


#--------

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors, Spock, and Lizard!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors, Spock, and Lizard. Good bye!'
  end

  def set_computer
    choice = %w(R2D2 Hal Chappie Sonny).sample
    @computer = case choice
                when 'R2D2'
                  R2D2.new
                when 'Hal'
                  Hal.new
                when 'Chappie'
                  Chappie.new
                when 'Sonny'
                  Sonny.new
                end
    computer.set_name
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    # binding.pry

    if human.move >(computer.move)
      puts "#{human.name} won!"
      human.update_score
    elsif human.move <(computer.move)
      puts "#{computer.name} won!"
      computer.update_score
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name}'s score: #{human.score} || #{computer.name}'s score: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp
      break if %w(y n).include? answer.downcase
      puts 'Sorry, must be y or n.'
    end

    return true if answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      set_computer
      human.choose
      computer.choose
      display_winner
      display_score
      if human.score == 10
        puts "#{human.name} won this round!"
        break
      else
        puts "#{computer.name} won this round!"
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
