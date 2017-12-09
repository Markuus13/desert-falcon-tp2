require "spec_helper"
require "ranking"

RSpec.describe Ranking do
  describe "initialize" do
    let (:expected_instance_variables) { %i[@file @scores] }

    it "has the right initial attributes" do
      rank = Ranking.new
      expect(rank.instance_variables).to match_array(expected_instance_variables)
    end
  end
  # describe "#initialize" do
  #   let (:expected_instance_variables) { %i[@background_image @draw_methods @enemies @falcon @font @hieros @obstacles @ranking @score @state @__swigtype__] }

  #   it "has the right initial attributes" do
  #     game_window = GameWindow.new(640, 480)
  #     expect(game_window.instance_variables).to match_array(expected_instance_variables)
  #   end
  # end
end
