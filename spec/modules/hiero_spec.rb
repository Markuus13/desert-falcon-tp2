require "spec_helper"
require "hiero"
require "falcon"

RSpec.describe Hiero do
  describe "#initialize" do
    let (:expected_instance_variables) { %i[@image @box @z_pos @x_vel @y_vel] }

    it "has the right initial attributes" do
      hiero = Hiero.new(10, 10, 0)
      expect(hiero.instance_variables).to match_array(expected_instance_variables)
    end
  end

  describe "#check_collision_with_falcon" do
    before(:each) do
      @falcon = Falcon.new(50, 50, 0)
      @hiero = Hiero.new(55, 55, 0)
    end

    it "detects collision between falcon and hiero" do
      expect(@hiero.notify_collision(@falcon.box))
    end
  end

  describe "#update" do
    before(:each) do
      @hiero = Hiero.new(55, 55, 0)
      @x = @hiero.x
      @y = @hiero.y
      @hiero.update
    end

    it "moves hiero" do
      expect(@x != @hiero.x && @y != @hiero.y)
    end
  end
end
