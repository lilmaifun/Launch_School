class SecretHandshake
  KEY = {
    1 => 'wink',
    10 => 'double blink',
    100 => 'close your eyes',
    1000 => 'jump'
  }

  def initialize(num)
    @num = num
  end

  def commands
    # need to convert decimal to binary
    # and then use binary code to output the secret handshake
    results = []

    if @num.class == String
      return [] if @num.scan(/\A[-+]?[0-9]+\z/) == []
      binary = @num.to_i
    elsif @num.class == Integer
      binary = convert_to_binary(@num)
    else
      return []
    end

    binary.to_s.chars.map(&:to_i).reverse.each_with_index do |num, index|
      if index < 4
        results << KEY[10**index] if num == 1
      elsif index == 4
        results.reverse!
      end
    end
    results
  end

  def convert_to_binary(decimal)
    (decimal).to_s(2)
  end
end

test = SecretHandshake.new('11001')
p test.commands