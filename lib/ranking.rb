class Ranking
  RANKING_PATH = "ranking.txt"

  def initialize
    @file = File.new(RANKING_PATH, "a+")
    @scores = []
  end

  def save(username, score)
    @file.puts "#{username} - #{score}"
    @file.close
  end

  def all_scores
    return @scores unless @scores.empty?
    File.open(RANKING_PATH, "r") do |f|
      f.each_line { |line| @scores << line }
    end
    @scores
  end
end
