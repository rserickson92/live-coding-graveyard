# 1. Given pairs of time intervals marked off/on, return ranges where it is "off"
# - rightmost of a pair determines state for that interval
# - can assume: always alternates between the two states, valid, not empty, positive numbers
# - don't know what first state is
# [[5, ON], [11, OFF], [16, ON], [19, OFF], [23, ON], [36, OFF], [38, ON]]
# => [[5, 11], [16, 19], [23, 36]]
#
# [[5, OFF], [11, ON], [16, OFF], [19, ON], [23, OFF], [36, ON], [38, OFF]]
# => [[0, 5], [11, 16], [19, 23], [36, 38]]
OFF = 0
ON = 1

def off_times(ranges)
  off_ranges = []
  current_range = []

  if ranges.first.last == OFF
    current_range << 0
  end

  ranges.each do |range|
    current_range << range.first

    if current_range.length == 2
      off_ranges << current_range
      current_range = []
    end
  end

  off_ranges.to_s
end

puts 'P1 Outputs:'
puts off_times([[5, ON], [11, OFF], [16, ON], [19, OFF], [23, ON], [36, OFF], [38, ON]])
puts off_times([[5, OFF], [11, ON], [16, OFF], [19, ON], [23, OFF], [36, ON], [38, OFF]])

# 2. Given array of "off" ranges from part 1, return a set of off ranges where
# any one range is "off"
# [
#   [[5, 11], [16, 19], [23, 36], [45, 49]],
#   [[4, 8], [15, 17], [42, 50], [55, 58]],
#   [[5, 9], [37, 39], [54, 60]]
# ]
# => [[4, 11], [15, 19], [23, 36], [37, 39], [42, 50], [54, 60]]

def union_off_ranges(off_ranges)
  sorted_off_ranges = off_ranges.flatten(1).compact.sort do |a, b|
    if (a.first == b.first)
      a.last <=> b.last
    else
      a.first <=> b.first
    end
  end

  output_ranges = []
  current_range = []
  prev_max_off_time = nil

  sorted_off_ranges.each do |off_range|
    if current_range.empty?
      current_range << off_range.first
    end

    if prev_max_off_time && prev_max_off_time < off_range.first
      current_range << prev_max_off_time
      output_ranges << current_range
      current_range = [off_range.first]
      prev_max_off_time = nil
    end

    if prev_max_off_time.nil? || prev_max_off_time < off_range.last
      prev_max_off_time = off_range.last
    end
  end

  last_off_range = sorted_off_ranges.last
  if prev_max_off_time > last_off_range.last
    current_range << prev_max_off_time
  else
    current_range << last_off_range.last
  end
  output_ranges << current_range

  output_ranges.to_s
end

puts 'P2 Outputs:'

puts union_off_ranges([
  [[5, 11], [16, 19], [23, 36], [45, 49]],
  [[4, 8], [15, 17], [42, 50], [55, 58]],
  [[5, 9], [37, 39], [54, 60]]
])

puts union_off_ranges([
  [[5, 11], [16, 19], [23, 36], [45, 49]],
  [[4, 8], [15, 17], [42, 50], [55, 58]],
  [[5, 9], [37, 39], [54, 57]]
])

puts union_off_ranges([
  [[1, 3]],
  [[4, 8]],
  [[9, 10]]
])

puts union_off_ranges([
  [[1, 3]],
  [[4, 8]],
])

puts union_off_ranges([
  [[1, 60]]
])