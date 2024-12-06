data_hor = File.open("04.txt").readlines.map(&:chomp).map(&:chars)
data_ver = data_hor.first.zip(*data_hor[1..])

def diagonal(data)
  [].tap do |rows|
    diagonal_data = data.dup.map.with_index { |row, n| row[n..] }
    rows.concat(diagonal_data[0].zip(*diagonal_data[1..])[..-4])
    (1..(data.size - 4)).each do |i|
      diagonal_data = data.dup[i..].map.with_index { _1[_2..] }
      rows << diagonal_data[0].zip(*diagonal_data[1..])[0]
    end
  end
end

puts(
  [
    *data_hor,
    *data_ver,
    *diagonal(data_hor),
    *diagonal(data_hor.map(&:reverse))
  ].map(&:join).flat_map do |line|
    line.scan(/XMAS/) + line.scan(/SAMX/)
  end.reject(&:empty?).count
)

puts(
  (0...data_hor.size-2).flat_map do |i|
    (0...data_hor.first.size-2).map do |j|
      data_hor[i...i+3].map { _1[j...j+3] }
    end
  end.select! do |a, b, c|
    "#{a[0]}#{b[1]}#{c[2]}" =~ /MAS|SAM/ &&
      "#{a[2]}#{b[1]}#{c[0]}" =~ /MAS|SAM/
  end.count
)
