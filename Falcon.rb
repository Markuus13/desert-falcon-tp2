require_relative 'GameObject'


class Falcon < GameObject

  public

  attr_accessor :x, :y, :z, :x_vel, :y_vel, :z_vel, :box

  def initialize(x_pos, y_pos, z_pos)
    @image = Sprite.new("assets/images/falcon.png")
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)
    @z = z_pos

    @x_vel = 3
    @y_vel = 1.5
    @z_vel = 40
  end

  def update; end

  def draw
    @image.render(@box.x, @box.y, 2)
  end

  def notifyCollision(object)
  end

  def move_left
    # puts "Falcon moved left"
    @box.x -= @x_vel
    @box.y -= @y_vel
  end

  def move_right
    # puts "Falcon moved right"
    @box.x += @x_vel
    @box.y += @y_vel
  end

  def move_up
    # puts "Falcon moved up"
    if @z < 1
      @z += 1
      @box.y -= @z_vel
      ## ISSO AQUI É GAMBIARRA!!! TEM QUE ARRUMAR DEPOIS
      sleep(0.2)
    end
  end

  def move_down
    # puts "Falcon moved down"
    if @z > -1
      @z -= 1
      @box.y += @z_vel
      ## ISSO AQUI É GAMBIARRA!!! TEM QUE ARRUMAR DEPOIS
      sleep(0.2)
    end
  end

end
