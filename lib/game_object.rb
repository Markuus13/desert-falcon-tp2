require "sprite"
require "box"

class GameObject
  def initialize(x_pos, y_pos, _z_pos, file_name)
    @image = Sprite.new(file_name)
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)
  end

  def destroy; end

  def update; end

  def render; end

  def equal?(another_game_object); end

  def dead?; end

  def notify_collision(another_box)
    @box.overlaps_with?(another_box)
  end
end
