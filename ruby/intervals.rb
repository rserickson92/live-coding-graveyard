# 1. Given pairs of time intervals marked off/on, return ranges where it is "off"
# - rightmost of a pair determines state for that interval
# - can assume: always alternates between the two states, valid, not empty
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

puts off_times([[5, ON], [11, OFF], [16, ON], [19, OFF], [23, ON], [36, OFF], [38, ON]])
puts off_times([[5, OFF], [11, ON], [16, OFF], [19, ON], [23, OFF], [36, ON], [38, OFF]])

# 2. Given array of "off" ranges from part 1, return a set of off ranges where
# any one range is "off"
