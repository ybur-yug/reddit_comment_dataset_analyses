require 'pry'
require 'json'
require 'sentimental'

FN = ARGV[0]

def get_comments
  JSON.parse(File.open(FN).read)['comments'] # array
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
    { comment: comment, score: score, sentiment: sentiment }
  end
end

def scores(results)
  results.map do |r|
    r[:score]
  end
end

def average_sentiment scores
  (scores.inject(0.0) { |sum, el| sum + el } / scores.size).round(4)
end

comments = get_comments # array of objs

res_1 = get_sentiments(comments, 0.6)
res_2 = get_sentiments(comments, 0.8)
res_3 = get_sentiments(comments, 0.4)

res_1_scores = scores(res_1)
res_2_scores = scores(res_2)
res_3_scores = scores(res_3)

res_1_avg_sentiment = average_sentiment(res_1_scores)
res_2_avg_sentiment = average_sentiment(res_2_scores)
res_3_avg_sentiment = average_sentiment(res_3_scores)

output = <<-SCORES
Comment Set Size: #{comments.length}\n
Result Three Avg Sentiment (threshold 0.4): #{res_3_avg_sentiment}\n
Result One Avg Sentiment (threshold 0.6): #{res_1_avg_sentiment}\n
Result Two Avg Sentiment (threshold 0.8): #{res_2_avg_sentiment}\n
SCORES

puts output
