require 'pry'

class InvalidCodonError < StandardError
end

class Translation
  KEY = {
    'Methionine' => %w(AUG),
    'Phenylalanine' => %w(UUU UUC),
    'Leucine' => %w(UUA UUG),
    'Serine' => %w(UCU UCC UCA UCG),
    'Tyrosine' => %w(UAU UAC),
    'Cysteine' => %w(UGU UGC),
    'Tryptophan' => %w(UGG),
    'STOP' => %w(UAA UAG UGA)
  }

  def self.of_codon(codon)
    raise InvalidCodonError if !self.is_valid?(codon)
    KEY.each do |key, value|
      return key if value.include?(codon)
    end
  end

  def self.is_valid?(codon)
    KEY.values.flatten.include?(codon)
  end

  def self.of_rna(strand)
    results = []
    strand.scan(/.{3}/).map do |codon|
      raise InvalidCodonError if !self.is_valid?(codon)
      break if KEY.values_at('STOP').flatten.include?(codon)
      results << self.of_codon(codon)
    end
    results
  end
end

p Translation.of_rna('UGG')