class Obstacle < GameObject
  attr_accessor :x_pos, :y_pos, :z_pos, :x_vel, :y_vel, :box

  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/obstacle.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @x_vel = 2
    @y_vel = 1
    @z_pos = z_pos
  end

  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  def draw
    @image.render(@box.x, @box.y, 1)
  end

  def notify_collision(object)
    @box.overlaps_with?(object)
  end
end
