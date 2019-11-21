# #1.
# arr = ['10', '11', '9', '7', '8']

# arr.sort do |a, b|
#   b.to_i <=> a.to_i
# end

# #2.
# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]

# books.sort_by do |book|
#   book[:published]
# end

# #3.
# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

# #=> arr1[2][1][3]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

# #=> arr2[1][:third][0]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]

# #=> arr3[2][:third][0][0]

# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

# #=> hsh1['b'][1]

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# #=> hsh2[:third].key(0)

# #4.
# arr1 = [1, [2, 3], 4]

# #=> arr1[1][1] = 4

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

# #=> arr2[2] = 4

# hsh1 = {first: [1, 2, [3]]}

# #=> hsh[:first][2][0] = 4

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

# #=> hsh2[['a']][:a][2] = 4

# #5.
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# total_male_age = 0
# munsters.each do |hash, value|
#   if value["gender"] == "male"
#     total_male_age += value["age"]
#   end
# end

# p total_male_age

# #6.
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# munsters.each do |key, value|
#   puts "#{hash} is a #{value["age"]}-year-old #{value["gender"]}"
# end

# #7.
# a = 2
# b = [5, 8]
# arr = [a, b]

# arr[0] += 2
# arr[1][0] -= a

# # a = 2
# # b = [3,8]

# #8.
# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# vowels = 'aeiou'
# hsh.each do |_, value|
#   value.each do |str|
#     str.chars.each do |char|
#       puts char if vowels.include?(char)
#     end
#   end
# end

# #9.
# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# arr.map do |sub_arr|
#   sub_arr.sort do |a, b|
#     b <=> a
#   end
# end

# #10.
# arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# arr.map do |hash|
#   new_hash = {}
#   hash.each do |key, value|
#     new_hash[key] = value+1
#   end 
#   new_hash
# end

# #11.
# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

# arr.map do |el|
#   el.select do |num|
#     num % 3 == 0
#   end
# end

# #12.
# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# new_hash = {}
# arr.each do |array|
#   new_hash[array[0]] = array[1]
# end

# p new_hash

# #13.
# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

# arr.sort_by do |sub_arr|
#   sub_arr.select do |num|
#     num.odd?
#   end
# end

# #14.
# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# hsh.map do |_, value|
#   if value[:type] == 'fruit'
#     value[:colors].map do |color| 
#       color.capitalize
#     end
#   elsif value[:type] == 'vegetable'
#     value[:size].upcase
#   end
# end

# #15.
# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# newarr = arr.select do |hsh|
#   hsh.all? do |_, value|
#     value.all? do |num|
#       num.even?
#     end
#   end
# end

# p newarr

#16.
def generate_UUID
  characters = []
  (0..9).each do |digit|
    characters << digit.to_s
  end
  ('a'..'f').each do |digit|
    characters << digit
  end

  p characters

  uuid = ""
  sections = [8, 4, 4, 4, 12]

  sections.each_with_index do |section, index|
    section.times do
      uuid += characters.sample
    end

    uuid += '-' unless index == sections.size - 1
  end

  uuid

end

p generate_UUID























