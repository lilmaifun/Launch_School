class Fixnum
  ROMAN_NUMERALS = 
  {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }

  def to_roman
    keys = ROMAN_NUMERALS.keys
    remaining = self
    roman_numeral = ''

    while remaining > 0
      keys.each do |key|
        next if remaining < key
        multiplier = remaining / key
        remaining = remaining % key
        roman_numeral << ROMAN_NUMERALS[key] * multiplier
      end
    end

    roman_numeral
  end
end

p 2.to_roman