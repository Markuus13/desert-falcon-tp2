class Box
  attr_accessor :x, :y, :width, :height

  def initialize(x_pos, y_pos, width, height)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
  end

  def overlaps_with?(another_object)
    return (self.x < another_object.x + another_object.width &&
            self.x + self.width > another_object.x &&
            self.y < another_object.y + another_object.height &&
            self.y + self.height > another_object.y)
  end
end
