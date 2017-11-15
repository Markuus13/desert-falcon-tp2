require "game_object"

class Enemy < GameObject
  attr_accessor :x, :y, :z, :x_vel, :y_vel, :box

  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/enemy/flying_enemy.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)

    @x = x_pos
    @y = y_pos
    @z = z_pos

    @x_vel = 2.5
    @y_vel = 1.25
  end

  def update
    @box.x -= x_vel
    @box.y += y_vel
  end

  def draw
    @image.render(@box.x, @box.y, 2)
  end

  def notify_collision(object)
    @box.overlaps_with?(object)
  end
end
