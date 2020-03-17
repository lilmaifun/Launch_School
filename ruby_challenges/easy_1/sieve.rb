class Sieve
  attr_reader :range

  def initialize(limit)
    @range = (2..limit).to_a
  end

  def primes
    primes = []
    index = 1
    
    @range.each do |num|
      @range.each do |n|
        if n % num == 0
          @range.delete(n) unless n == num
        end
      end
      @range
    end
  end

end

test = Sieve.new(120)
p test.primes