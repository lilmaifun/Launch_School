require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open('sample_text.txt')
    @text = @file.read
    @text_object = Text.new(@text)
  end

  # omitted for brevity

  def test_word_count
    
    assert_equal 72, @text_object.word_count
  end

  def teardown
    @file.close
  end
end