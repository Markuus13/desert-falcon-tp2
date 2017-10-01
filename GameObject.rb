require_relative 'Sprite'
require_relative 'Box'


class GameObject
  public

  def initialize(x_pos, y_pos, z_pos, file_name)
    @image = Sprite.new(file_name)
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)
  end

  def destroy
  end

  def update
  end

  def render
  end

  def isEqual
  end

  def isDead(object)
  end

  def notifyCollision(object)
    return self.overlapsWith(object)
  end

end
