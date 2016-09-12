class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @highest_wf_count = 0
    @highest_wf_words = []
    @content = content
    @line_number = line_number
    self.calculate_word_frequency(@content, @line_number)
  end


  def calculate_word_frequency(content, line_number)
    word_frequency = Hash.new(0)
    content.split.each do |word|
      word_frequency[word.downcase] += 1
    end
    @highest_wf_count = word_frequency.values.max
    @highest_wf_words = Hash[word_frequency.select { |word, count| count == highest_wf_count}].keys
  end
end

#  Implement a class called Solution. 
class Solution
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers

  def initialize
    @analyzers = []
  end

  def analyze_file
    line_number = 0
    File.foreach("test.txt") do |content|
      line_number += 1
      @analyzers << LineAnalyzer.new(content, line_number)
    end
  end

  def calculate_line_with_highest_frequency
    freq = []
    self.analyzers.select { |x| freq << x.highest_wf_count }
    @highest_count_across_lines = freq.max
    @highest_count_words_across_lines ||= []
    self.analyzers.each do |line|
      @highest_count_words_across_lines << line if line.highest_wf_count == self.highest_count_across_lines
    end
  end

  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line|
      puts "#{line.highest_wf_words} appears in line #{line.line_number}"
    end
  end
end