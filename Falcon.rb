require_relative 'GameObject'


class Falcon < GameObject
  public

  def initialize(x_pos, y_pos, z_pos)
    @image = Gosu::Image.new("assets/images/falcon.png")
    @x = x_pos
    @y = y_pos
    @z = z_pos

    @x_vel = @y_vel = @z_vel = 1
  end

  def update
  end

  def draw
    @image.draw(@x, @y, 1)
  end

  def notifyCollision(object)
  end

  def move_left
    puts "Falcon moved left"
    @x -= 2
    @y -= 1
  end

  def move_right
    puts "Falcon moved right"
    @x += 2
    @y += 1
  end

  def move_up
    puts "Falcon moved up"
    @y -= 2
  end

  def move_down
    puts "Falcon moved down"
    @y += 2
  end

end
