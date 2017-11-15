require "spec_helper"
require "game_object"

RSpec.describe GameObject do
  describe "#initialize" do
    let (:game_object) { GameObject.new(10, 10, 1, "assets/falcon/falcon_001.jpeg") }
    let (:expected_instance_variables) { %i[@image @box] }

    it "has the right initial attributes" do
      expect(game_object.instance_variables).to match_array(expected_instance_variables)
    end
  end

  describe "#notify_collision" do
    it "returns true when any collision is detected" do
      game_object = GameObject.new(10, 10, 1, "assets/falcon/falcon_001.jpeg")
      another_box = Box.new(10, 10, 32, 32)
      expect(game_object.notify_collision(another_box)).to eq true
    end

    it "returns false when no collision is detected" do
      game_object = GameObject.new(10, 10, 1, "assets/falcon/falcon_001.jpeg")
      another_box = Box.new(60, 60, 10, 10)
      expect(game_object.notify_collision(another_box)).to eq false
    end
  end
end
