class Box
  attr_accessor :x, :y, :width, :height

  def initialize(x_pos, y_pos, width, height)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
  end

  def destroy; end

  def overlaps_with?(another_object)
    (x < another_object.x + another_object.width &&
            x + width > another_object.x &&
            y < another_object.y + another_object.height &&
            y + height > another_object.y)
  end
end
