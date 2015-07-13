require 'pry'
require 'json'
require 'sentimental'

FNS = `ls processed`.split("\n")

def get_comments(fn)
  data = File.open(fn).read
  JSON.parse(data)['comments']
end

def get_analyzer(threshold)
  Sentimental.load_defaults
  Sentimental.threshold = threshold
  Sentimental.new
end

def get_sentiments(comments, threshold)
  analyzer = get_analyzer(threshold)
  comments.map do |c|
    { comment: c['body'],
      score: analyzer.get_score(comment),
      sentiment: analyzer.get_sentiment(comment) }
  end
end

def scores(results)
  results.map { |r| r[:score] }
end

def average_sentiment scores
  scores.inject(0.0) { |sum, el| sum + el } / scores.size
end

def count_negatives results
  results.map { |r| r[:sentiment] }.select { |s| s == :negative }.count
end

def count_positives results
  results.map { |r| r[:sentiment] }.select { |s| s == :positive }.count
end

def count_positives results
  results.map { |r| r[:sentiment] }.select { |s| s == :neutral }.count
end

def run_month
  all_scores         = []
  all_avg_sentiments = []
  all_pos            = []
  all_neg            = []
  all_neutral        = []
  FNS.each do |fn|
    get_comments("processed/#{fn}")
    res = get_sentiments(comments, 0.6)
    res_scores = scores(res)
    res_avg_sentiment = average_sentiment(res_scores)
    res_negs = count_negatives(res)
    res_pos = count_positives(res)
    res_neutral = count_positives(res)
    all_scores << res_scores
    all_avg_sentiments << res_avg_sentiment
    all_pos << res_pos
    all_neg << res_negs
    all_neutral << res_neutral
  end
  binding.pry
  puts 'done'
end

def run_sample
  comments = get_comments('data_sample.json')

  res_1 = get_sentiments(comments, 0.6)
  res_2 = get_sentiments(comments, 0.8)
  res_3 = get_sentiments(comments, 0.4)

  res_1_scores = scores(res_1)
  res_2_scores = scores(res_2)
  res_3_scores = scores(res_3)

  res_1_avg_sentiment = average_sentiment(res_1_scores)
  res_2_avg_sentiment = average_sentiment(res_2_scores)
  res_3_avg_sentiment = average_sentiment(res_3_scores)

  res_1_negs = count_negatives(res_1)
  res_2_negs = count_negatives(res_2)
  res_3_negs = count_negatives(res_3)

  res_1_pos = count_positives(res_1)
  res_2_pos = count_positives(res_2)
  res_3_pos = count_positives(res_3)

  res_1_neutral = count_positives(res_1)
  res_2_neutral = count_positives(res_2)
  res_3_neutral = count_positives(res_3)

  <<-SCORES
  Comment Set Size: #{comments.length}\n
  Result Three Avg Sentiment (threshold 0.4): #{res_3_avg_sentiment}\n
  Result Three Positive Sentiment Count: #{res_3_pos}\n
  Result Three Negative Sentiment Count: #{res_3_negs}\n
  Result Three Neutral Sentiment Count: #{res_3_neutral}\n\n

  Result One Avg Sentiment (threshold 0.6): #{res_1_avg_sentiment}\n
  Result One Positive Sentiment Count: #{res_1_pos}\n
  Result One Negative Sentiment Count: #{res_1_negs}\n
  Result One Neutral Sentiment Count: #{res_1_neutral}\n\n

  Result Two Avg Sentiment (threshold 0.8): #{res_2_avg_sentiment}\n
  Result Two Positive Sentiment Count: #{res_2_pos}\n
  Result Two Negative Sentiment Count: #{res_2_negs}\n
  Result Two Neutral Sentiment Count: #{res_2_neutral}\n\n
  SCORES
end

run_sample
# run_month
