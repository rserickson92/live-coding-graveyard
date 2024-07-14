# Part 1: Got a working solution
# Given an array of numbers and a pattern of space-separated strings,
# determine if the array "matches" the pattern. A match in this case
# is a consistent "mapping" of a number to a string - in other words,
# if we find a string that is already "mapped" to a different number,
# it's invalid.

# Examples:
#
# [1, 1, 1, 2], "alpha alpha alpha beta" => true
# [1, 2, 3, 4, 5], "live coding gives impostor syndrome" => true
# 
# [1, 2, 1, 2], "a b c b" => false
# ^1 should be 'a' and we got 'c'
#
# [1, 2, 3, 2, 1], "a b c b a" => true
# [1, 2, 3, 2, 1], "a b c b b" => false
# ^We established 1 is "a" so 1 can't also be "b"
#
# [1, 2, 3, 4], "same same same same" => true
# ^Note it is alright for different numbers to have the same string
# [1, 2, 1, 2], "same diff diff same" => false

def match_pattern(numbers, candidate)
  items = candidate.split(' ')
  return false if numbers.length != items.length

  matches = {}
  numbers.each_with_index do |n, i|
    item = items[i]
    return false if !matches[n].nil? && matches[n] != item

    matches[n] = item
  end

  true
end

puts '[1, 1, 1, 2], "alpha alpha alpha beta" => true'
puts "=> #{match_pattern([1, 1, 1, 2], 'alpha alpha alpha beta')}"

puts '[1, 2, 3, 4, 5], "live coding gives impostor syndrome" => true'
puts "=> #{match_pattern([1, 2, 3, 4, 5], 'live coding gives impostor syndrome')}"

puts '[1, 2, 1, 2], "a b c b" => false'
puts "=> #{match_pattern([1, 2, 1, 2], 'a b c b')}"

puts '[1, 2, 3, 2, 1], "a b c b a" => true'
puts "=> #{match_pattern([1, 2, 3, 2, 1], 'a b c b a')}"

puts '[1, 2, 3, 2, 1], "a b c b b" => false'
puts "=> #{match_pattern([1, 2, 3, 2, 1], 'a b c b b')}"

puts '[1, 2, 3, 4], "same same same same" => true'
puts "=> #{match_pattern([1, 2, 3, 4], 'same same same same')}"

puts '[1, 1, 1, 1], "same same same same" => true'
puts "=> #{match_pattern([1, 1, 1, 1], 'same same same same')}"

puts '[1, 2, 1, 2], "same diff diff same" => false'
puts "=> #{match_pattern([1, 1, 1, 2], 'same diff diff same')}"

# Part 2: Couldn't wrap my head around the recursion before the
# hour was up, which is likely why I failed. I have not seen this
# category of problem since college and the occasional recursive
# Leetcode problem wasn't sufficient in the moment.
#
# Now there is a "metapattern" which a shorthand way of describing
# several possible patterns. Find if the candidate matches any
# of the patterns described by the metapattern.

# Example:
# [[1, 2], [3], [1, 2]] means:
# - The first number can be 1 or 2
# - The second number must be 2
# - The third number can be 1 or 2
# Thus here is a list of all possible patterns described:
# [[1, 2, 1], [1, 2, 2], [2, 2, 1], [2, 2, 2]]
# From here, if a candidate pattern matches any of these possibilities, it's valid.
# Otherwise it's not.
# [[1, 2], [2], [1, 2]], "a b a" => true (pattern 0)
# [[1, 2], [2], [1, 2]], "a b b" => true (pattern 1)
# [[1, 2], [2], [1, 2]], "b b a" => true (pattern 2)
# [[1, 2], [2], [1, 2]], "b b b" => true (pattern 3)
# [[1, 2], [2], [1, 2]], "a b c" => false (matches no pattern)

def match_metapattern(metapattern, candidate)
  items = candidate.split(' ')
  return false if metapattern.length != items.length

  metapattern.first.any? do |pattern_int|
    match_subpattern(pattern_int, items.first, metapattern[1..], items[1..], {})
  end
end

def match_subpattern(cur_pattern_int, item, rest_of_mp, rest_of_items, matches)
  return false if !matches[cur_pattern_int].nil? && matches[cur_pattern_int] != item
  return true if rest_of_mp.empty?

  matches[cur_pattern_int] = item
  rest_of_mp.first.any? do |pattern_int|
    match_subpattern(pattern_int, rest_of_items.first, rest_of_mp[1..], rest_of_items[1..], matches.dup)
  end
end

puts '[[1, 2], [2], [1, 2]], "a b a" => true'
puts "=> #{match_metapattern([[1, 2], [2], [1, 2]], "a b a")}"

puts '[[1, 2], [2], [1, 2]], "a b b" => true'
puts "=> #{match_metapattern([[1, 2], [2], [1, 2]], "a b b")}"

puts '[[1, 2], [2], [1, 2]], "b b a" => true'
puts "=> #{match_metapattern([[1, 2], [2], [1, 2]], "b b a")}"

puts '[[1, 2], [2], [1, 2]], "b b b" => true'
puts "=> #{match_metapattern([[1, 2], [2], [1, 2]], "b b b")}"

puts '[[1, 2], [2], [1, 2]], "a b c" => false'
puts "=> #{match_metapattern([[1, 2], [2], [1, 2]], "a b c")}"

puts '[[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "d d b b a d" => true'
puts "=> #{match_metapattern([[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "d d b b a d")}"

puts '[[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "d d b b a c" => false'
puts "=> #{match_metapattern([[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "d d b b a c")}"

puts '[[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "e d c b a b" => false'
puts "=> #{match_metapattern([[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "e d c b a b")}"

puts '[[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "c d c b a d" => true'
puts "=> #{match_metapattern([[3, 4], [4], [3, 2], [3, 2], [1], [1, 4]], "c d c b a d")}"

# TODO if spare time: optimize runtime (e.g. memoization, "similar patterns")
