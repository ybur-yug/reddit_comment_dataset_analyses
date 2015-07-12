require 'pry'

def preprocess(fn)
  f = File.open(fn).read
  line_num = 1
  lines = []
  f.each_line do |line|
    if line_num == 1
      line = "{\"comments\": [" + line
      lines << line
      line_num += 1
    elsif line_num < 10000
      lines << line
      line_num += 1
    else
      line = line + "]}"
      lines << line
    end
  end
  all = lines.join
  File.open("processed/#{fn}_processed.json", "wb") do |f|
    f.write(all)
  end
end
