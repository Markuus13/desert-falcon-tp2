require 'gosu'

require_relative 'Falcon'
require_relative 'Hiero'
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
    @background_image = Sprite.new("assets/images/grass_background.png")

    @font = Gosu::Font.new(20)

    @falcon = Falcon.new(width/4.0, 3*height/4.0, 0)
  end

  def quit
    close
  end

  # Game logic
  def update
    
    # Get user inputs
    # Move Falcon
    f_box = @falcon.box
    x_next_left  = f_box.x - @falcon.x_vel
    y_next_left  = f_box.y - @falcon.y_vel
    x_next_right = f_box.x + f_box.width + @falcon.x_vel
    y_next_right = f_box.y + f_box.height + @falcon.y_vel
    # #z_next_up    = @falcon
    # #z_next_down  = 

    @falcon.move_left  if (Gosu.button_down? Gosu::KbLeft)  &&
                          x_next_left > 0 && y_next_left > 0
                          # (@falcon.x - @falcon.x_vel) > 0   &&
                          # (@falcon.y - @falcon.y_vel) > 0
    @falcon.move_right if (Gosu.button_down? Gosu::KbRight) &&
                          x_next_right < self.width &&
                          y_next_right < self.height
                          # (@falcon.x + @falcon.x_vel) < self.width &&
                          # (@falcon.y + @falcon)
    @falcon.move_up    if (Gosu.button_down? Gosu::KbUp)    #&&
    @falcon.move_down  if (Gosu.button_down? Gosu::KbDown)  #&&


    # Move Hiero

    # Detect collision
    # if @falcon.overlapsWith(@hiero)
    #   TODO: Do something
    # end

    # TODO: remaining updates
    @fps = Gosu::fps.to_s
        
  end

  def draw
    #puts fps
    @font.draw("FPS: #{fps}", (self.width - 80), (self.height - 40), 0xff_ff0000)
    @falcon.draw
    @background_image.render(0, 0, 0)
  end

end
