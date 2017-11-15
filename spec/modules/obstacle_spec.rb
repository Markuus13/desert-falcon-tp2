require "spec_helper"
require "obstacle"

RSpec.describe Obstacle do
  describe "#initialize" do
    let (:expected_instance_variables) { %i[@image @box @x_vel @y_vel @z_pos] }

    it "has the correct initial values" do
      obstacle = Obstacle.new(10, 10, 0)
      expect(obstacle.instance_variables).to match_array(expected_instance_variables)
    end
  end
end
