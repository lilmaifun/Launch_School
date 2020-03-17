class Octal
  BASE = 8

  def initialize(string)
    @string = string
    @nums = string.reverse.chars.map(&:to_i)
  end

  def input_invalid?
    @string =~ /\D|[8-9]/
  end

  def to_decimal
    return 0 if input_invalid?
    decimal = 0

    @nums.each_with_index do |digit, index|
      decimal += digit*(BASE**index)
    end
    decimal
  end
end

test = Octal.new('011')
puts test.to_decimal