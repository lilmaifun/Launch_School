# # 1.
# 10.times {|num| puts (" " * num) + "The Flintstones Rock!"}

# # 2.
# puts "the value of 40 + 2 is " + (40 + 2)
# # The result is an error because (40+2) is an integer and it cannot be concatenated to a string.
# # To fix it:
# # - (40 + 2).to_s
# # - ("#{40 + 2}")

# # 3.
# def factors(number)
#   divisor = number
#   factors = []
#   while divisor > 0 do
#     factors << number / divisor if number % divisor == 0
#     divisor -= 1
#   end 
#   factors
# end

# # The purpose of number % divisor == 0 is to ensure that the divisor is a factor of the number.
# # Line 8 is used so that the method returns the array in factors.

# # 4.
# def rolling_buffer1(buffer, max_buffer_size, new_element)
#   buffer << new_element
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end

# def rolling_buffer2(input_array, max_buffer_size, new_element)
#   buffer = input_array + [new_element]
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end

# # The difference between the two is that << will alter the caller whereas the + will not.

# # 5.
# limit = 15

# def fib(first_num, second_num)
#   while first_num + second_num < limit
#     sum = first_num + second_num
#     first_num = second_num
#     second_num = sum
#   end
#   sum
# end

# result = fib(0, 1)
# puts "result is #{result}"

# # The limit variable, since it's a local variable, cannot be accessed within the method defintion.

# # 6.
# answer = 42

# def mess_with_it(some_number)
#   some_number += 8
# end

# new_answer = mess_with_it(answer)

# p answer - 8

# # The output of the following code is 34.

# 7.
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

#Since munsters was passed in, the local variable now points to different data locations.

# 8.
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
#=> "paper"

# 9.
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)

#=> "no"

