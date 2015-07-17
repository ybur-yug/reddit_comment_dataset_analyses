require 'json'
require_relative 'analyzer'

all_data = []

Dir.foreach('../data') do |month|
  if month != '.' && month != '..'
    Dir.foreach("../data/#{month}/split") do |part|
      if part != '.' && part != '..'
        comments = File.open("../data/#{month}/split/#{part}").read.split("\n").map do |line|
          JSON.parse(line)
        end
        data = Analyzer.new(comments, 0.4).sentiments
        data.each { |s| s[:month] = month }
        all_data << data
      end
    end
  end
end

all_data.flatten!

File.open('../results', 'w') do |f|
  all_data.each do |comment|
    f.write "#{comment.to_json}\n"
  end
end
