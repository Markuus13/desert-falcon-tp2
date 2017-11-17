require "sprite"
require "box"

# Class GameObject is a generalization for every "living" element
# on the game, such as the falcon, hieros, obstacles and enemies.
class GameObject
  # Initialize GameObject object with it's generic attributes.
  # @param x_pos [Integer] x coordinate where the game object will be created
  # @param y_pos [Integer] y coordinate
  # @param _z_pos [Integer] z coordinate
  # @param file_name [String] image file name for the object
  def initialize(x_pos, y_pos, _z_pos, file_name)
    @image = Sprite.new(file_name)
    @box = Box.new(x_pos, y_pos, @image.width, @image.height)
  end

  # Destructor for the game object.
  def destroy; end

  # Update object's status.
  def update; end

  # Renders object image.
  def render; end

  # Check wheter a game object is equal to another.
  # @param another_game_object [Object] game object to be checked
  # @return [Boolean] if both game objects are equal
  def equal?(another_game_object); end

  # Notify if game object is dead.
  def dead?; end

  # Notify if the game object's box collides (overlaps) another
  # game object's box.
  # @param another_box [Object] game object's box to be checked collision
  # @return [Boolean] if the collision occurs
  def notify_collision(another_box)
    @box.overlaps_with?(another_box)
  end
end
