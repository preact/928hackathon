require 'json'
require 'redis'

def redis
  @redis_client ||= Redis.new(:host => "192.168.1.10", :database => 7)
end

def riak
  @riak_client ||= Riak::Client.new(:nodes => [
        {:host => 'ec2-50-16-172-76.compute-1.amazonaws.com'},
        {:host => 'ec2-54-243-23-98.compute-1.amazonaws.com'},
        {:host => 'ec2-54-221-81-11.compute-1.amazonaws.com'},
        {:host => 'ec2-54-226-94-108.compute-1.amazonaws.com'},
        {:host => 'ec2-184-72-173-119.compute-1.amazonaws.com'}
      ])
end

def process
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
end

process
