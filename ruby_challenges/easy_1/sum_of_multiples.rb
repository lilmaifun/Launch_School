class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def self.to(limit)
    new(3,5).to(limit)
  end

  def to(limit)
    result = []
    (0..limit).each do |num|
      result << num if multiples_of_factor?(num)
    end
    result.reduce(&:+)
  end

  def multiples_of_factor?(num)
    @multiples.each do |n|
      return true if num % n == 0
    end
    false
  end
end
