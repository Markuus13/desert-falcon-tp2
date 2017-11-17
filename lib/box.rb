# Class Box simulates the game object box and holds it's attributes,
# such as the position of the entity on the window and it's size.
class Box
  attr_accessor :x, :y, :width, :height

  # Initialize Box object
  # @param x_pos [Integer] x coordinate where the box is
  # @param y_pos [Integer] y coordinate where the box is
  # @param width [Integer] object's width in pixels
  # @param height [Integer] object's height in pixels
  def initialize(x_pos, y_pos, width, height)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
  end

  # Destructor for the box
  def destroy; end

  # Checks wheter there is a collision between two boxes.
  # @param another_object [Object] box to be checked collision
  # @return [Boolean] if a collision occurs
  def overlaps_with?(another_object)
    (x < another_object.x + another_object.width &&
            x + width > another_object.x &&
            y < another_object.y + another_object.height &&
            y + height > another_object.y)
  end
end
