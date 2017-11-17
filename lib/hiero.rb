# Class Hiero inherits GameObject and instantiates every "good" item
# the falcon can collect.
class Hiero < GameObject
  attr_accessor :x, :y, :z, :x_vel, :y_vel, :box

  # Initialize Hiero object.
  # @param x_pos [Integer] x coordinate of the object.
  # @param y_pos [Integer] y coordinate
  # @param z_pos [Integer] z coordinate
  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/hiero.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @z_pos = z_pos
    @x_vel = 2
    @y_vel = 1
  end

  # Updates Hiero position.
  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  # Draws Hiero image.
  def draw
    @image.render(@box.x, @box.y, 1)
  end

  # Notify Hiero collision with another object.
  def notify_collision(object)
    @box.overlaps_with?(object)
  end
end
