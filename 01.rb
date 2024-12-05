data = File.open("01.txt").readlines.map(&:chomp).map(&:split)
first = data.map(&:first).map(&:to_i)
last = data.map(&:last).map(&:to_i)

# Part 1
puts first.sort.zip(last.sort).map { _1.inject(&:-).abs }.sum

# Part 2
last.group_by(&:itself).transform_values!(&:size).then do |hist|
  puts first.sum { _1 * (hist[_1] || 0) }
end
