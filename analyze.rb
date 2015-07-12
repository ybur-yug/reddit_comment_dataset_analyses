require 'pry'
require 'json'
require 'sentimental'

FN = ARGV[0]

def get_comments
  JSON.parse(File.open(FN).read)['comments']
end

def get_analyzer(threshold)
  Sentimental.load_defaults
  Sentimental.threshold = threshold
  Sentimental.new
end

def get_sentiments(comments, threshold)
  analyzer = get_analyzer(threshold)
  comments.map do |c|
    comment = c['body']
    score = analyzer.get_score(comment)
    sentiment = analyzer.get_sentiment(comment)
    { comment: comment, score: score, sentiment: sentiment }.to_json
  end
end

comments = get_comments
res = { results: get_sentiments(comments, 0.6) }.to_json
File.open("results.json", "wb") do |f|
  f.write res
end
