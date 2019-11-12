#3.
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
#=> "My string looks like this now: pumpkins"
puts "My array looks like this now: #{my_array}"
#=> "My array looks like this now: ["pumpkins", "rutabaga"]"

#4.
def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
#=> "My string looks like this now: pumpkinsrutabaga"
puts "My array looks like this now: #{my_array}"
#=> "My array looks like this now: [pumpkins"

#5.
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += "rutabaga"

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

#6.
def color_valid(color)
  color == "blue" || color == "green"
end

p color_valid("blue")
#=> true
