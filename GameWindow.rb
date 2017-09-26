require 'gosu'

require_relative 'Falcon'
require_relative 'Hiero'
require_relative 'Box'
require_relative 'Sprite'


class GameWindow < Gosu::Window

  private

  def button_down(id)
    puts "KEY_ID = #{id}"
    if id == Gosu::KbEscape
      self.quit
    else
      super
    end
  end


  public

  attr_accessor :fps

  def initialize(width, height)
    super width, height
    self.caption = "Desert Falcon v0.0.0"

    # TODO: load images with Sprite
    @background_image = Gosu::Image.new("assets/images/grass_background.png")

    @font = Gosu::Font.new(20)

    @falcon = Falcon.new(width/4.0, 3*height/4.0, 1)
  end

  def quit
    close
  end

  # Game logic
  def update
    
    # Get user inputs
    # Move Falcon
    @falcon.move_left  if Gosu.button_down? Gosu::KbLeft
    @falcon.move_right if Gosu.button_down? Gosu::KbRight
    @falcon.move_up    if Gosu.button_down? Gosu::KbUp
    @falcon.move_down  if Gosu.button_down? Gosu::KbDown


    # Move Hiero

    # Detect collision

    # TODO: remaining updates
    @fps = Gosu::fps.to_s
        
  end

  def draw
    #puts fps
    @font.draw("FPS: #{fps}", (self.width - 80), (self.height - 40), 0xff_ff0000)
    @falcon.draw
    @background_image.draw(0, 0, 0)
  end

end
