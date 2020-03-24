# Given an array, and a window size w, find the 
# maximum range (max - min) within a set of w elements.

# naive solution
def windowed_max_range(array, window_size)
  current_max_range = nil

  array.each_index do |i|
    subarray = array[i...(i + window_size)] 
    range = subarray.max - subarray.min

    if current_max_range.nil? || range > current_max_range
      current_max_range = range 
    end
  end

  current_max_range
end

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

####### Data Structures #######

class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def enqueue(element)
    @store << element
  end

  def dequeue
    @store.shift
  end
end

class MyStack
  def initialize
    @store = []
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def pop
    @store.pop
  end

  def push(element)
    @store << element
  end
end

class StackQueue
  def initialize
    @stack1 = MyStack.new
    @stack2 = MyStack.new
  end

  def size
    @stack1.size + @stack2.size
  end

  def empty?
    @stack1.empty? && @stack2.empty?
  end

  def enqueue(element)
    @stack1.push(element)
  end

  def dequeue
    @stack1.size.times { @stack2.push(@stack1.pop) } if @stack2.empty?
    @stack2.pop
  end
end

# implementation best for solution max window range
class MinMaxStack
  def initialize
    @store = []
  end

  def peek
    @store.last[0] unless empty?
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def max
    @store.last[2] unless empty?
  end

  def min
    @store.last[1] unless empty?
  end

  def pop
    popped_element = @store.pop
    popped_element[0]
  end

  def push(element)
    if empty?
      @store << [element, element, element]
    else
      current_min = min < element ? min : element
      current_max = max > element ? max : element
      @store << [element, current_min, current_max]
    end
  end
end

# alternative implementation: min and max are stored in parallel stacks
class MinMaxStack2
  def initialize
    @store = []
    @min_store = []
    @max_store = []
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def max
    @max_store.last
  end

  def min
    @min_store.last
  end

  def pop
    popped_ele = @store.pop
     
    if popped_ele == @max_store.last
      @max_store.pop
    end

    if popped_ele == @min_store.last
      @min_store.pop
    end
  end

  def push(element)
    @store << element

    if @max_store.empty? || element >= @max_store.last
      @max_store << element
    end
    
    if @min_store.empty? || element <= @min_store.last
      @min_store << element
    end
  end
end

class MinMaxStackQueue
  def initialize
    @stack1 = MinMaxStack.new
    @stack2 = MinMaxStack.new
  end

  def size
    @stack1.size + @stack2.size
  end

  def empty?
    @stack1.empty? && @stack2.empty?
  end

  def enqueue(element)
    @stack1.push(element)
  end

  def dequeue
    @stack1.size.times { @stack2.push(@stack1.pop) } if @stack2.empty?

    @stack2.pop
  end

  def max
    return @stack2.max if @stack1.empty?
    return @stack1.max if @stack2.empty?

    @stack1.max > @stack2.max ? @stack1.max : @stack2.max
  end

  def min
    return @stack2.min if @stack1.empty?
    return @stack1.min if @stack2.empty?

    @stack1.min < @stack2.min ? @stack1.min : @stack2.min
  end
end

# Optimized solution
def max_windowed_range(array, window_size)
  current_max_range = nil
  current_window = MinMaxStackQueue.new

  array.each do |ele|
    current_window.enqueue(ele)
    if current_window.size == window_size
      range = current_window.max - current_window.min
      if current_max_range.nil? || range > current_max_range
        current_max_range = range 
      end
      current_window.dequeue
    end
  end
  current_max_range
end

# p max_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8