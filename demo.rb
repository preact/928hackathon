require 'json'

people = {}
event_count = 0
people_counts = Hash.new(0)

while line = gets
  data = JSON.parse(line)
  p = data["person"]
  email = p["email"]
  people[email] = p
  people_counts[email] += 1
  event_count += 1
end

people_counts.sort_by{ |k,v| v * -1 }.each do |k,v|
  puts "#{v}\t#{k}"
end

puts "found #{people.count} total people"
puts "found #{event_count} total events"
