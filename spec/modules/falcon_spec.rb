require "spec_helper"
require "falcon"
require "hiero"

RSpec.describe Falcon do
  describe "#initialize" do
    let (:expected_instance_variables) { %i[@image @box @z @x_vel @y_vel @z_vel] }

    it "has the right initial attributes" do
      falcon = Falcon.new(10, 10, 1)
      expect(falcon.instance_variables).to match_array(expected_instance_variables)
    end
  end

  describe "#move_left" do
    before(:each) do
      @falcon = Falcon.new(10, 10, 1)
    end

    it "subtracts falcon x coordinate by its x velocity" do
      @pos_x_before_move_left = @falcon.box.x
      @falcon.move_left
      @pos_x_after_move_left = @falcon.box.x
      expect(@pos_x_after_move_left).to eq(@pos_x_before_move_left - @falcon.x_vel)
    end

    it "subtracts falcon y coordinate by its y velocity" do
      @pos_y_before_move_left = @falcon.box.y
      @falcon.move_left
      @pos_y_after_move_left = @falcon.box.y
      expect(@pos_y_after_move_left).to eq(@pos_y_before_move_left - @falcon.y_vel)
    end
  end

  describe "#move_right" do
    before(:each) do
      @falcon = Falcon.new(10, 10, 1)
    end

    it "add falcon x coordinate by its x velocity" do
      @pos_x_before_move_right = @falcon.box.x
      @falcon.move_right
      @pos_x_after_move_right = @falcon.box.x
      expect(@pos_x_after_move_right).to eq(@pos_x_before_move_right + @falcon.x_vel)
    end

    it "add falcon y coordinate by its y velocity" do
      @pos_y_before_move_right = @falcon.box.y
      @falcon.move_right
      @pos_y_after_move_right = @falcon.box.y
      expect(@pos_y_after_move_right).to eq(@pos_y_before_move_right + @falcon.y_vel)
    end
  end

  describe "#move_up" do
    before(:each) do
      @falcon = Falcon.new(10, 10, 0)
    end

    context "when z coordinate is small than 1" do
      it "increase falcon coordinate z by 1" do
        @pos_z_before_move_up = @falcon.z
        @falcon.move_up
        @pos_z_after_move_up = @falcon.z
        expect(@pos_z_after_move_up).to eq(@pos_z_before_move_up + 1)
      end
    end
  end

  describe "#move_down" do
    before(:each) do
      @falcon = Falcon.new(10, 10, 0)
    end

    context "when z coordinate is bigger than -1" do
      it "decrease falcon coordinate z by 1" do
        @pos_z_before_move_down = @falcon.z
        @falcon.move_down
        @pos_z_after_move_down = @falcon.z
        expect(@pos_z_after_move_down).to eq(@pos_z_before_move_down - 1)
      end
    end
  end

  describe "#check_movement_left" do
    before(:each) do
      @falcon = Falcon.new(1, 10, 0)
    end

    it "tries to move left" do
      expect(@falcon.move_left_possible? == false)
    end
  end

  describe "#check_movement_right" do
    before(:each) do
      @falcon = Falcon.new(600, 10, 0)
    end

    it "tries to move right" do
      expect(@falcon.move_right_possible?(640, 480) == false)
    end
  end

  describe "#check_movement_up" do
    before(:each) do
      @falcon = Falcon.new(1, 1, 0)
    end

    it "tries to move up" do
      expect(@falcon.move_up_possible? == false)
    end
  end

  describe "#check_movement_down" do
    before(:each) do
      @falcon = Falcon.new(20, 450  , 0)
    end

    it "tries to move down" do
      expect(@falcon.move_down_possible?(480) == false)
    end
  end

  describe "#check_collision_with_hiero" do
    before(:each) do
      @falcon = Falcon.new(50, 50, 0)
      @hiero = Hiero.new(55, 55, 0)
    end

    it "detects collision between falcon and hiero" do
      expect(@falcon.notify_collision(@hiero.box))
    end
  end
end
