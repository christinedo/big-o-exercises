# O(n!) combinatorial time
# O(n!) combinatorial space
def first_anagram?(str1, str2)
  generate_anagrams = str1.split("").permutation.to_a
  possible_anagrams = generate_anagrams.map(&:join)
  possible_anagrams.include?(str2)
end

# O(n^2)
# O(n) linear space
def second_anagram?(str1, str2)
  str2_array = str2.split("")
  str1.each_char do |letter|
    idx = str2_array.find_index(letter)
    return false if idx.nil?
    str2_array.delete_at(idx)
  end
  str2_array.empty?
end

# O(n log n) bc sorting algorithm
# O(n) linear space
def third_anagram?(str1, str2)
  str1.split("").sort == str2.split("").sort
end

# O(n) bc of populating hash table
# O(1) constant space 
# Explainer
# Here, the intuitive answer to the space complexity is
# O(n) because we're adding a separate key in the hash
# for each character. But if the keys in the hash are single 
# characters, then how many different keys can we have? 
# How many different chars in the alphabet? A constant number 
# (26 + numbers and symbols for English alphabet).

def fourth_anagram?(str1, str2)
  str1_hash = Hash.new(0)
  str2_hash = Hash.new(0)

  str1.each_char { |letter| str1_hash[letter] += 1 }
  str2.each_char { |letter| str2_hash[letter] += 1 }

  str1_hash == str2_hash
end

p fourth_anagram?("resistance", "ancestries")
p third_anagram?("resistance", "ancestries")
p second_anagram?("resistance", "ancestries")
# p first_anagram?("resistance", "ancestries")