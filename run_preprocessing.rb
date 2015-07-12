require_relative 'preprocess'
require 'pry'

FILES = `ls`.split("\n")

FILES.each do |fn|
  preprocess(fn)
end
