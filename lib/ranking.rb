# Class Ranking create, sort and stores all ranking information,
# such as the player name and highest score.
class Ranking
  RANKING_PATH = "ranking.txt".freeze # Ranking file name

  # Initializes the Ranking object
  def initialize
    @file = File.new(RANKING_PATH, "a+")
    @scores = []
  end

  # Write the username and score passed as argument into the ranking file.
  # @param username [String]
  # @param score [String]
  # @return [Boolean] true or false depending on file closing.
  def save(username, score)
    @file.puts "#{username} - #{score}"
    @file.close
  end

  # Return all ranks of ranking file sorted by score on desc order
  # @return [Array<String>] ordered ranks
  def all_scores
    return @scores unless @scores.empty?
    File.open(RANKING_PATH, "r") do |f|
      f.each_line { |line| @scores << line }
    end
    order(@scores)
  end

  private

  # Organizes scores
  def order(_scores)
    @scores = @scores.map { |elem| elem.split(" - ") }.
      to_h.
      sort_by { |_key, value| value.to_i }.
      map { |elem| elem.join(" - ") }.
      reverse[0..9]
  end
end
