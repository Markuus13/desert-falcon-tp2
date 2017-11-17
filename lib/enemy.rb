require "game_object"

# Class Enemy inherits GameObject and represents the enemies to the falcon.
# The enemies move faster.
class Enemy < GameObject
  attr_accessor :x, :y, :z, :x_vel, :y_vel, :box

  # Initialize Enemy object.
  # @param x_pos [Integer] x coordinate where the enemy will be created
  # @param y_pos [Integer] y coordinate
  # @param z_pos [Integer] z coordiante
  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/enemy/flying_enemy.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @x = x_pos
    @y = y_pos
    @z = z_pos

    @x_vel = 2.5
    @y_vel = 1.25
  end

  # Updates enemy position.
  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  # Draws enemy image on the screen.
  def draw
    @image.render(@box.x, @box.y, 2)
  end

  # Checks if the enemy collides with another object.
  def notify_collision(object)
    @box.overlaps_with?(object)
  end
end
