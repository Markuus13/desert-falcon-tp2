require 'spec_helper'
require 'falcon'

RSpec.describe Falcon do
  describe '#initialize' do
    let (:expected_instance_variables) { %i[@image @box @z @x_vel @y_vel @z_vel] }

    it 'has the right initial attributes' do
      falcon = Falcon.new(10, 10, 1)
      expect(falcon.instance_variables).to match_array(expected_instance_variables)
    end
  end

  describe '#move_left' do
    before(:each) do
      @falcon = Falcon.new(10, 10, 1)
    end

    it 'subtracts falcon x coordinate by its x velocity' do
      @pos_x_before_move_left = @falcon.box.x
      @falcon.move_left
      @pos_x_after_move_left = @falcon.box.x
      expect(@pos_x_after_move_left).to eq(@pos_x_before_move_left - @falcon.x_vel)
    end

    it 'subtracts falcon y coordinate by its y velocity' do
      @pos_y_before_move_left = @falcon.box.y
      @falcon.move_left
      @pos_y_after_move_left = @falcon.box.y
      expect(@pos_y_after_move_left).to eq(@pos_y_before_move_left - @falcon.y_vel)
    end
  end

  describe '#move_right' do
    before(:each) do
      @falcon = Falcon.new(10, 10, 1)
    end

    it 'add falcon x coordinate by its x velocity' do
      @pos_x_before_move_right = @falcon.box.x
      @falcon.move_right
      @pos_x_after_move_right = @falcon.box.x
      expect(@pos_x_after_move_right).to eq(@pos_x_before_move_right + @falcon.x_vel)
    end

    it 'add falcon y coordinate by its y velocity' do
      @pos_y_before_move_right = @falcon.box.y
      @falcon.move_right
      @pos_y_after_move_right = @falcon.box.y
      expect(@pos_y_after_move_right).to eq(@pos_y_before_move_right + @falcon.y_vel)
    end
  end

  describe '#move_up' do
    before(:each) do
      @falcon = Falcon.new(10, 10, 0)
    end

    context 'when z coordinate is small than 1' do
      it 'increase falcon coordinate z by 1' do
        @pos_z_before_move_up = @falcon.z
        @falcon.move_up
        @pos_z_after_move_up = @falcon.z
        expect(@pos_z_after_move_up).to eq(@pos_z_before_move_up + 1)
      end
    end
  end

  describe '#move_down' do
    before(:each) do
      @falcon = Falcon.new(10, 10, 0)
    end

    context 'when z coordinate is bigger than -1' do
      it 'decrease falcon coordinate z by 1' do
        @pos_z_before_move_down = @falcon.z
        @falcon.move_down
        @pos_z_after_move_down = @falcon.z
        expect(@pos_z_after_move_down).to eq(@pos_z_before_move_down - 1)
      end
    end
  end
end
