require 'pry'
class Phrase
  def initialize(string)
    @string = string.scan(/\b[a-zA-Z0-9]+\'?[a-z]*\b/)
  end

  def word_count
    key_list = Hash.new

    @string.map(&:downcase).uniq.each do |word|
      key_list[word] = 0
    end
    
    @string.each do |word|
      key_list.each_key do |k|
        if word.downcase == k.downcase
          key_list[k] += 1

        end
      end
    end
    key_list
  end
end

test = Phrase.new('one day i will i')
p test.word_count
