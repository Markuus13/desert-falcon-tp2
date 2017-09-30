require 'gosu'


class Sprite < Gosu::Image
  public

  def initialize(file_name)
    @image = Gosu::Image.new(file_name)
  end

  def destroy
  end

  def render(x, y, z)
    @image.draw(x, y, z)
  end

  def width
    return @image.width
  end

  def height
    return @image.height
  end

end