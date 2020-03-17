class Trinary
  BASE = 3

  def initialize(string)
    @string = string
    @nums = string.reverse.chars.map(&:to_i)
  end

  def input_valid?
    @string =~ /^[0-2]*$/
  end

  def to_decimal
    return 0 unless input_valid?
    decimal = 0

    @nums.each_with_index do |digit, index|
      decimal += digit*BASE**index
    end

    decimal
  end
end

test = Trinary.new('0a1b2c')
p test.to_decimal