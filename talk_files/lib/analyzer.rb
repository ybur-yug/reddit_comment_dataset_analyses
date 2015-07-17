require 'sentimental'

class Analyzer
  def initialize(comments, threshold)
    @comments = comments
    Sentimental.load_defaults
    Sentimental.threshold = threshold
    @analyzer = Sentimental.new
  end

  def sentiments
    @sentiments = @comments.map do |comment|
      { comment:   comment['body'],
        score:     @analyzer.get_score(comment['body']),
        sentiment: @analyzer.get_sentiment(comment['body']) }
    end
  end
end
