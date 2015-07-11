DATA_FILE = ARGV[0]

def preprocess
  data = File.open(DATA_FILE).read
  scrubbed_data = []
  data.each_line do |l|
    l.gsub!("null", "")
    l.gsub!("true", "True")
    l.gsub!("false", "False")
    scrubbed_data << l
  end
  File.open("processed_data.json", "wb") do |f|
    scrubbed_data.each do |l|
      f.write l
    end
  end
  puts "Preprocessing complete"
end

preprocess
