require 'spec_helper'
require 'hiero'

RSpec.describe Hiero do
  describe '#initialize' do
    let (:expected_instance_variables) { %i[@image @box @z_pos @x_vel @y_vel] }

    it 'has the right initial attributes' do
      hiero = Hiero.new(10, 10, 0)
      expect(hiero.instance_variables).to match_array(expected_instance_variables)
    end
  end
end
