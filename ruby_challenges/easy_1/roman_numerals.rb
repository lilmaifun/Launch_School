class Fixnum

  ROMAN_NUMERAL_RULES = {
    'M' => 1000,
    'CM' => 900,
    'D' => 500,
    'C' => 100,
    'XC' => 90,
    'L' => 50,
    'XL' => 40,
    'X' => 10,
    'IX' => 9,
    'V' => 5,
    'IV' => 4,
    'I' => 1
  }

  def to_roman
    roman_numeral = ""
    number = self
    ROMAN_NUMERAL_RULES.each do |key, value|
      number_of_roman_letters = number / value
      roman_numeral += number_of_roman_letters * roman_number
      number -= number_of_roman_letters * value
    end
    roman_numeral
  end
end

2.to_roman
2.to_roman