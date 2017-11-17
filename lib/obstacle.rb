# Class Obstacle inherits GameObject and act as a barrier to the falcon.
# If the falcon collides with it, the falcon dies.
class Obstacle < GameObject
  attr_accessor :x_pos, :y_pos, :z_pos, :x_vel, :y_vel, :box

  # Initialize Obstacle object.
  # @param x_pos [Integer] x coordinate where the obstacle will be created
  # @param y_pos [Integer] y coordinate
  # @param z_pos [Integer] z coordiante
  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/obstacle.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @x_vel = 2
    @y_vel = 1
    @z_pos = z_pos
  end

  # Updates obstacle position.
  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  # Draws obstacle image on the screen.
  def draw
    @image.render(@box.x, @box.y, 1)
  end

  # Checks if the obstacle collides with another object.
  def notify_collision(object)
    @box.overlaps_with?(object)
  end
end
