# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done 

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
    description == otherTodo.description &&
    done == otherTodo.done
  end
end

#---------------------------------------------------------

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(task)
    if task.instance_of? Todo
      @todos << task
    else
      raise TypeError, 'Can only add Todo objects'
    end
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def done?
    todos.all? do |task|
      task.done? == true
    end
  end 

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    @todos.fetch(index).done!
  end

  def mark_undone_at(index)
    @todos.fetch(index).undone!
  end

  def done!
    @todos.each_index do |index|
      mark_done_at(index)
    end
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def to_s
    text = "----#{title}----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each
    counter = 0
    while counter < todos.size
      yield(todos.fetch(counter))
      counter += 1
    end
    self
  end

  def select
    results = TodoList.new(title)
    each do |todo|
      results << todo if yield(todo)
    end
    results
  end
 
  # find_by_title takes a string as argument, and returns the first Todo object that matches the argument. Return nil if no todo is found.
  def find_by_title(str)
    result = nil
    each do |todo|
      if todo.title == str
        result = todo
      end
      break if todo.title == str
    end
    result
  end

  # returns new TodoList object containing only the done items
  def all_done
    select do |task|
      task.done?
    end
  end

  # returns new TodoList object containing only the not done items
  def all_not_done
    select do |task|
      task.done? == false
    end
  end

  # takes a string as argument, and finds the first Todo object that matches, and marks the task as done
  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  # mark every todo as done
  def mark_all_done
    each { |task| task.done! }
  end

  def mark_all_undone
    each { |task| task.undone! }
  end

end

#---------------------------------------------------------

# tests given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3) 

puts list.mark_done("Buy milk")

