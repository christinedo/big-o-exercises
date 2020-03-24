# Minimum
# Given a list of integers find the smallest number in the list.
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# my_min(list)  # =>  -5

# Phase I
# First, write a function that compares each element to every other element of
# the list. Return the element if all other elements in the array are larger.
# What is the time complexity for this function?

#O(n^2) quadratic time
#O(1) constant space
def my_min_I(array)
  array.each_with_index do |ele1, i|
    smallest = true
    array.each_with_index do |ele2, j|
      next if i == j
      smallest = false if ele1 > ele2
    end
    return ele1 if smallest
  end
end

# Phase II
# Now rewrite the function to iterate through the list just once while keeping
# track of the minimum. What is the time complexity?

#O(n) linear time
#O(1) constant space
def my_min_II(array)
  minimum = array[0]

  array.each do |ele|
    minimum = ele if minimum > ele
  end

  minimum
end

# Largest Contiguous Sub-sum
# Find the sums of all contiguous sub-arrays and return the max.

# Example
# list = [2, 3, -6, 7, -6, 7]
# largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

# Phase I
# Write a function that iterates through the array and finds all sub-arrays
# using nested loops. First make an array to hold all sub-arrays.
# Then find the sums of each sub-array and return the max.

#O(n^3) cubic time
#O(n^3) cubic space
def largest_contiguous_subsum_I(array)
  subarrays = []

  array.each_index do |i|
    (i...array.length).each do |j|
      subarrays << array[i..j]
    end
  end

  subarrays.map { |array| array.sum }.max
end

# Phase II
# Write a new function using O(n) time with O(1) memory.
# Keep a running tally of the largest sum.

def largest_contiguous_subsum_II(array)
  current = 0
  largest_sum = array[0]
  
  array.each_with_index do |ele, i|
    current += ele
    if current > largest_sum
      largest_sum = current
    elsif current < 0
      current = 0
    end
  end
  largest_sum
end