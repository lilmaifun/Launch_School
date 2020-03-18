require 'pry'

class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def self.to(limit)
    new(3,5).to(limit)
  end

  def to(limit)
    result = []
    (0..limit-1).each do |number|
      result << number if multiples_of_factor?(number)
    end
    p result
    result.reduce(&:+)
  end

  def multiples_of_factor?(number)
    @multiples.each do |n|
      return true if number % n == 0
    end
    false
  end
end

puts SumOfMultiples.to(20)
