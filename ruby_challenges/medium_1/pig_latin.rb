require 'pry'
class PigLatin
  def self.translate(str)
    str.split.each do |word|
      # if word is a consonant
      if word.scan(/^[aeiou]|^(y|x)[^aeiou]+/).empty?
        word << word.slice!(/^[^aeiouq]*(qu)*/)
      end
      word << 'ay'
    end.join(' ')
  end
end

p PigLatin.translate('quick fast run')
