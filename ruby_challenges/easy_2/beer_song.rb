class BeerSong
  def get_verse(num)
    if num > 2 && num < 100
      "#{num} bottles of beer on the wall, #{num} bottles of beer.\nTake one down and pass it around, #{num-1} bottles of beer on the wall.\n"
    elsif num == 2
      "#{num} bottles of beer on the wall, #{num} bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
    elsif num == 1
      "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
    elsif num == 0
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    else
      raise ArgumentError, 'input out of range (0..99)'
    end
  end

  def verse(num)
    get_verse(num)
  end

  def lyrics
    verses(99, 0)
  end

  def verses(start, stop)
    start.downto(stop).map {|verse| get_verse(verse)}.join("\n")
  end
end

puts BeerSong.new.lyrics

