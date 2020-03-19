def reverse_odd_words(str)
  arr = str.scan(/\b[\w]*\b/)
  arr.delete("")
  arr.each_with_index do |word, index|
    word.reverse! if index.odd?
  end
  result = arr.join(" ")
  p result << '.'
end

reverse_odd_words("")
reverse_odd_words(".")
reverse_odd_words("hello")
reverse_odd_words("hello word.")
reverse_odd_words("hello   word   .")
reverse_odd_words("hello word   .")
reverse_odd_words("whats the matter with kansas.")

