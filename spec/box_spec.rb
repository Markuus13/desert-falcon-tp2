require 'box'

RSpec.describe Box do
  describe "#overlaps_with?" do
    context "when one box overlaps another" do
      it "returns true" do
        box1 = Box.new(100, 100, 32, 32)
        box2 = Box.new(100, 100, 40, 40)
        expect(box1.overlaps_with? box2).to eq true
      end
    end

    context "when one box doesn't overlaps another" do
      it "returns false" do
        box1 = Box.new(100, 100, 10, 10)
        box2 = Box.new(110, 110, 10, 10)
        expect(box1.overlaps_with? box2).to eq false
      end
    end
  end
end
