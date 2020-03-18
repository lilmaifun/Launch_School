class PerfectNumber
  def self.classify(num)
    raise RuntimeError if num < 0

    divisors = []
    1.upto(num) do |n|
      divisors << n if num % n == 0 unless num == n
    end

    if num == divisors.reduce(:+)
      "perfect"
    elsif num < divisors.reduce(:+)
      "abundant"
    else num > divisors.reduce(:+)
      "deficient"
    end
  end
end

p PerfectNumber.classify(6)