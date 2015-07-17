SPLIT_SIZE = 2 # this is set small for sample data, set it
               # to a value appropriate for your machine when
               # using it on the real dataset from reddit (10k is safe)

Dir.foreach("../data/") do |dir|
  if dir != '.' && dir != '..'
    Dir.mkdir "../data/#{dir}/split"
    `split -l #{SPLIT_SIZE} ../data/#{dir}/month.json ../data/#{dir}/split/data-`
  end
end
