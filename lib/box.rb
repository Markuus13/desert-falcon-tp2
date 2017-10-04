class Box
  attr_accessor :x, :y, :width, :height

  def initialize(x_pos, y_pos, width, height)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
  end

  def destroy
  end

  def overlapsWith(object)
    return (self.x < object.x + object.width &&
            self.x + self.width > object.x &&
            self.y < object.y + object.height &&
            self.y + self.height > object.y)
  end
end
