class Series
  attr_reader :numbers

  def initialize(string)
    @numbers = string.each_char.map(&:to_i)
  end

  def slices(count)
    raise ArgumentError, "String slice input has exceeded the number string!" if count > @numbers.length
    numbers = []
    original_length = count
    index = 0

    while index != @numbers.length
      numbers << @numbers[index..(count-1)]
      count += 1
      index += 1 

      numbers.pop && break if numbers.last.length != original_length
    end

    numbers
  end
    
end

two = Series.new('01234')
p two.slices(4)