class Sieve
  attr_reader :range

  def initialize(limit)
    @range = (2..limit).to_a
  end

  def primes
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