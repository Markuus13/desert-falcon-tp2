require_relative 'GameObject'


class Box
  public

  def initialize(x_pos, y_pos, width, height)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
  end

  def destroy
  end

# if (rect1.x < rect2.x + rect2.width &&
#    rect1.x + rect1.width > rect2.x &&
#    rect1.y < rect2.y + rect2.height &&
#    rect1.height + rect1.y > rect2.y) {
#     // collision detected!
# }

  def overlapsWith(object)
    return (self.x < object.x + object.width &&
            self.x + self.width > object.x &&
            self.y < object.y + object.height &&
            self.y + self.height > object.y)
  end

end
