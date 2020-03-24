# Given an array of unique integers and a target sum,
# determine whether any two integers in the array sum to that amount.

# O(n^2) quadratic time complexity
# O(1) constant space complexity? (edit: yes!)
def bad_two_sum?(arr, target_sum)
  arr.each do |ele1|
    arr.each do |ele2|
      next if ele1 == ele2
      return true if ele1 + ele2 == target_sum
    end
  end
  false
end

# O(n log n) time complexity
# O(n) linear space
def okay_two_sum?(arr, target_sum)
  sorted = arr.sort
  sorted.any? do |ele|
    next if ele == (target_sum - ele)
    binary_search(sorted, (target_sum - ele))
  end
end

# for the purpose of two_sum, returns true if found in array
def binary_search(arr, target)
  right = arr.length - 1
  left = 0

  while left <= right
    middle = (left + right) / 2
    if arr[middle] > target
      right = middle - 1
    elsif arr[middle] < target
      left = middle + 1
    else
      return true
    end
  end
  return false
end

# O(n) bc hash tables has O(1) look-up
# O(n) space complexity? (edit: yes!)
def two_sum?(arr, target_sum)
  num_hash = {}
  arr.each do |ele|
    return true if num_hash.has_key?(target_sum - ele)
    num_hash[ele] = true
  end
  false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false