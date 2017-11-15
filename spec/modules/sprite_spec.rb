require 'spec_helper'
require 'sprite'

RSpec.describe Sprite do
  describe '#initialize' do
    let (:expected_instance_variables) { %i[@image @__swigtype__] }

    it 'has the right initial attributes' do
      sprite = Sprite.new('assets/falcon/falcon_001.jpeg')
      expect(sprite.instance_variables).to match_array(expected_instance_variables)
    end
  end
end
