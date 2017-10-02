require_relative 'GameObject'


class Hiero < GameObject
  public

  attr_accessor :x, :y, :z, :x_vel, :y_vel, :box

  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/hiero.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @z_pos = z_pos
    @x_vel = 2
    @y_vel = 1
  end

  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  def draw
    @image.render(@box.x, @box.y, 1)
  end

  def notifyCollision(object)
    return self.box.overlapsWith(object)
  end

end
