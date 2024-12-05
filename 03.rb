def scan_lines(part = 1)
  data = File.open("03.txt").readlines.map(&:chomp)
  enabled = true

  data.sum do |line|
    line.scan(/(mul|do|don't)\((\d+)?,?(\d+)?\)/)
      .map do |inst, a, b|

      case inst
      when "do"
        enabled = true; nil
      when "don't"
        enabled = false; nil
      when "mul"
        a.to_i * b.to_i if enabled || part == 1
      end
    end.compact.sum
  end
end

puts scan_lines
puts scan_lines(2)
