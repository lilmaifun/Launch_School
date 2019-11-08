VALID_CHOICES = %w(rock paper scissors lizard spock).freeze
SHORTEN_CHOICES = %w(r p s l).freeze
player_score = 0
computer_score = 0

game_key = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['paper', 'spock'],
  'spock' => ['scissors', 'rock']
}

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
  (first == 'paper' && second == 'rock') ||
  (first == 'scissors' && second == 'paper') ||
  (first == 'rock' && second == 'lizard') ||
  (first == 'lizard' && second == 'spock') ||
  (first == 'spock' && second == 'scissors') ||
  (first == 'scissors' && second == 'lizard') ||
  (first == 'lizard' && second == 'paper') ||
  (first == 'paper' && second == 'spock') ||
  (first == 'spock' && second == 'rock')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('Computer won!')
  else
    prompt("It's a tie!")
  end
end

def decipher_choices(choice)
  if choice == 'r'
    'rock'
  elsif choice == 'p'
    'paper'
  elsif choice == 's'
    prompt('scissors or spock?')
    gets.chomp
  elsif choice == 'l'
    'lizard'
  end
end


def prompt(message)
  Kernel.puts("=> #{message}")
end

loop do
  choice = ""
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    elsif SHORTEN_CHOICES.include?(choice)
      choice = decipher_choices(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

#score keeper
  if win?(choice, computer_choice)
    player_score += 1
  elsif choice == computer_choice
  else
    computer_score += 1
  end

  prompt("Your score: #{player_score}; Computer's score: #{computer_score}")

  if player_score == 5
    prompt('You are the GRAND WINNER!!!')
    break
  elsif computer_score == 5
    prompt('Computer is the grand winner!')
    break
  end

  prompt('Do you want to play again?')
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Thank you for playing. Good bye!')
