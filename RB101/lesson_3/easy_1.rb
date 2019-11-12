#1.
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# => 
# 1
# 2
# 2
# 3

#2.
# ! and ? are Ruby syntax.
# 1. != means not equal to
# 2. !user_name means making something the opposite of their boolean value
# 3. words.uniq! means making a method destructive
# 4. putting ? before something is a ternary operator
# 5. putting ? after something means making it returns a boolean value
# 6. putting !! before something means turning that object into their boolean value

#3.
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent')

#4.
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)
#=>numbers is now [1, 3, 4, 5]
numbers.delete(1)
#=>numbers is now [2, 3, 4, 5]

#5.
(10..100).include?(42)

#6.
famous_words = "seven years ago..."

famous_words.prepend('Four scores and ')
"Four scores and " + famous_words

#7.
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

eval(how_deep)

#8.
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!

#9.
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.assoc("Barney")


