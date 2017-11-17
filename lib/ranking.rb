class Ranking
  RANKING_PATH = "ranking.txt".freeze

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
    order(@scores)
  end

  private

  def order(scores)
    @scores = @scores.map { |elem| elem.split(" - ") }
                     .to_h
                     .sort_by { |_key, value| value.to_i }
                     .map { |elem| elem.join(" - ") }
                     .reverse
  end
end
