require "gosu"

# Class Sprite that inherits Gosu::Image handles image files from game objects.
class Sprite < Gosu::Image
  # Initialize Sprite object that inherits Gosu::Image.
  # @param file_name [String] the image used file name
  def initialize(file_name)
    @image = Gosu::Image.new(file_name)
  end

  # Destructor for Sprite object.
  def destroy; end

  # Invokes Gosu::Image.draw method to render image on the game window.
  # @param x [Integer] x coordinate where the image will be drawn
  # @param y [Integer] y coordinate where the image will be drawn
  # @param z [Integer] z coordinate where the image will be drawn
  def render(x, y, z)
    @image.draw(x, y, z)
  end

  # Invokes Gosu::Image.width method.
  # @return [Integer] image width in pixels
  def width
    @image.width
  end

  # Invokes Gosu::Image.height method.
  # @return [Integer] image height in pixels
  def height
    @image.height
  end
end
