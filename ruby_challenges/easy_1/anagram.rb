# PEDAC
# inputs: string, array of words 
# PROBLEM: 
#   - find the anagrams in the list
# EXAMPLES: 
#   - input: "listen"
#   - list: "enlists" "google" "inlets" "banana"
#   - anagrams: "inlets"
# DATA STRUCTURE:
#   - string > array > array
# ALGORITHM:
#   - intialize a results array
#   - iterate through the list of words
#   - check if the element is the same size as the letters array
#     - if not the same length
#       - next
#     - if same length
#       - put the element as the argument into a method that
#         checks if the word is an anagram of the key word
#       - if it returns true, then push into results array
#       - if false do nothing
#   - return results array
require 'pry'
class Anagram
  def initialize(word)
    @word = word
  end

  def match(list)
    results = []
    list.each do |el|
      next if el.size != @word.size
      results << el if anagram?(el)
    end
    results
  end

  private

  def anagram?(word)
    @word.chars.sort == word.chars.sort
  end
end

test = Anagram.new('listen')
p test.match(["enlists", "google", "inlets", "banana"])