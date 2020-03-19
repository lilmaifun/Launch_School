require 'pry'
class Luhn
  def initialize(num)
    @num = num
    @actual_nums = []
  end

  def addends
    # converts the num to array of actaul nums

    @num.to_s.chars.map(&:to_i).reverse.each_with_index do |num, index|
      if index.even?
        @actual_nums << num
      elsif index.odd?
        result = num*2
        if result < 10
          @actual_nums << result
          # binding.pry
        elsif result >= 10
          @actual_nums << (result - 9)
        end
      end
    end
    @actual_nums.reverse
  end

  def checksum
    self.addends if @actual_nums == []
    @actual_nums.reduce(&:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(num)
    new_base_num = num * 10
    if new(new_base_num).valid?
      new_base_num
    else
      remainder = new(new_base_num).checksum % 10
      new_base_num + (10 - remainder)
    end
  end
end

luhn = Luhn.new(12_121)
# p luhn.addends
p luhn.addends