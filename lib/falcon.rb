require "game_object"

# Class Falcon is the player's playable character
class Falcon < GameObject
  attr_accessor :x, :y, :z, :x_vel, :y_vel, :z_vel, :box

  # Initialize Falcon object
  # @param x_pos [Integer] x coordinate where the falcon will be created
  # @param y_pos [Integer] y coordiante
  # @param z_pos [Integer] z coordinate
  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/falcon.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)
    @z = z_pos

    @x_vel = 3
    @y_vel = 1.5
    @z_vel = 40
  end

  # Draws falcon image.
  def draw
    @image.render(@box.x, @box.y, 2)
  end

  # Notifies collision between falcon and another game object.
  def notify_collision(object)
    @box.overlaps_with?(object)
  end

  # Moves falcon to the left.
  def move_left
    @box.x -= @x_vel
    @box.y -= @y_vel
  end

  # Moves falcon to the right.
  def move_right
    @box.x += @x_vel
    @box.y += @y_vel
  end

  # Moves falcon up.
  def move_up
    if @z < 1
      @z += 1
      @box.y -= @z_vel
      sleep(0.2)
    end
  end

  # Moves falcon down.
  def move_down
    if @z > -1
      @z -= 1
      @box.y += @z_vel
      sleep(0.2)
    end
  end

  # Checks if it is possible to move falcon to the left.
  # @return [Boolean] if it is possible to move
  def move_left_possible?
    x_next_left = @box.x - x_vel
    y_next_left = @box.y - y_vel
    (x_next_left > 0) && (y_next_left > 0)
  end

  # Checks if it is possible to move falcon to the right.
  # @param width [Integer] Game window's width in pixels
  # @param height [Integer] Game window's height in pixels
  # @return [Boolean] if it is possible to move
  def move_right_possible?(width, height)
    x_next_right = @box.x + @box.width + x_vel
    y_next_right = @box.y + @box.height + y_vel
    (x_next_right < width) && (y_next_right < height)
  end

  # Check if it is possible to move falcon up.
  # @return [Boolean] if it is possible to move
  def move_up_possible?
    z_next_up = @box.y - z_vel
    z_next_up > 0
  end

  # Check if it is possible to move falcon down.
  # @return [Boolean] if it is possible to move
  def move_down_possible?(height)
    z_next_down = @box.y + @box.height + z_vel
    z_next_down < height
  end
end
