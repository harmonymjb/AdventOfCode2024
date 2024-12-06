rule_strs, runs = File.open("05.txt").read.split("\n\n").map { _1.split("\n") }

rules = {}
reverse = {}
rule_strs.each do |rule|
  a, b = rule.match(/([^|]+)\|([^|]+)/).captures.map(&:to_i)
  rules[b] ||= []
  rules[b] << a
  reverse[a] ||= []
  reverse[a] << b
end

runs.map! do |run|
  run.split(",").map(&:to_i)
end

runs, bad_runs = runs.partition do |run|
  run.map.with_index do |page, i|
    run[...i].any? { rules[_1]&.include?(page) }
  end.none?
end

puts runs.sum { |run| run[run.size/2] }

bad_runs.map { _1.sort! { |a, b| reverse[a]&.include?(b) ? -1 : 1 } }

puts bad_runs.sum { |run| run[run.size/2] }
