# PROBLEM
#   - calculate the Hamming distance between two DNA strands
# EXAMPLES
#   - assert_equal 0, DNA.new('GGACTGA').hamming_distance('GGACTGA')
#   - assert_equal 3, DNA.new('ACT').hamming_distance('GGA')
# DATA STRUCTURE
#   - string > integer
# ALGORITHM
#   - initialize total = 0
#   - determine which is the shorter strand, use shorter strand as
#     key strand
#     - assign smaller size strand to variable key_strand
#   - iterate through key_strand.chars with each_with_index
#     - compare each el of key_strand to the index of the second strand
#     - if they are not equal, add to total
#   - return total
# CODE
require 'pry'
class DNA
  def initialize(dna_strand)
    @dna_strand = dna_strand
  end

  def hamming_distance(second_dna_strand)
    total = 0
    if @dna_strand.size != second_dna_strand.size
      @dna_strand.size > second_dna_strand.size ? key_strand = second_dna_strand : key_strand = @dna_strand
      @dna_strand.size < second_dna_strand.size ? second_strand = second_dna_strand : second_strand = @dna_strand
    else
      key_strand = @dna_strand
      second_strand = second_dna_strand
    end

    key_strand.chars.each_with_index do |letter, index|
      letter == second_strand[index] ? nil : total += 1
    end
    total
  end
end

test = DNA.new('ACT')
puts test.hamming_distance('GGA')
