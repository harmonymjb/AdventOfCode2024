data = File.open("02.txt").readlines.map(&:chomp).map { _1.split.map(&:to_i) }

def safe?(report)
  (report.sort == report || report.sort == report.reverse) &&
    report.zip(report.rotate)[...-1].map do |a, b|
    a != b && (a - b).abs <= 3
  end.all?
end

count = data.count do |report|
  safe?(report)
end

puts count

count = data.count do |report|
  safe?(report) || report.map.with_index do |_, i|
    safe?(report.dup.tap { _1.delete_at(i) })
  end.any?
end

puts count
