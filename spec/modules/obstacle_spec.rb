require "spec_helper"
require "obstacle"
require "falcon"

RSpec.describe Obstacle do
  describe "#initialize" do
    let (:expected_instance_variables) { %i[@image @box @x_vel @y_vel @z_pos] }

    it "has the correct initial values" do
      obstacle = Obstacle.new(10, 10, 0)
      expect(obstacle.instance_variables).to match_array(expected_instance_variables)
    end
  end

  describe "#check_collision_with_falcon" do
    before(:each) do
      @falcon = Falcon.new(100, 120, 0)
      @obstacle = Obstacle.new(110, 120, 0)
    end

    it "detects collision between falcon and obstacle" do
      expect(@obstacle.notify_collision(@falcon.box))
    end
  end

  describe "#update" do
    before(:each) do
      @obstacle = Obstacle.new(150, 80, 0)
      @x = @obstacle.x_pos
      @y = @obstacle.y_pos
      @obstacle.update
    end

    it "moves obstacle" do
      expect(@x != @obstacle.x_pos && @y != @obstacle.y_pos)
    end
  end
end
