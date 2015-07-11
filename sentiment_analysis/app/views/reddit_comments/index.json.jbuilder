json.array!(@reddit_comments) do |reddit_comment|
  json.extract! reddit_comment, :id, :comment_text, :sentiment
  json.url reddit_comment_url(reddit_comment, format: :json)
end
