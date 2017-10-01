require 'gosu'

require_relative 'Falcon'
require_relative 'Hiero'
require_relative 'Sprite'


class GameWindow < Gosu::Window

  private
  
  attr_accessor :fps, :background_image_path, :falcon_image_path, :hiero_image_path, :title

  # @background_image_path = "assets/images/grass_background.png"
  @title = "Desert Falcon"

  def button_down(id)
    puts "KEY_ID = #{id}"
    if id == Gosu::KbEscape
      self.quit
    else
      super
    end
  end


  public

  def initialize(width, height)
    super width, height
    self.caption = @title
    Random.new_seed

    # TODO: load images with Sprite
    @background_image = Sprite.new("assets/images/sand_background.jpg")
    @font = Gosu::Font.new(20)

    @falcon = Falcon.new(width/4.0, 3*height/4.0, 0)

    @hiero = Array.new
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
    z_next_up    = f_box.y - @falcon.z_vel
    z_next_down  = f_box.y + f_box.height + @falcon.z_vel

    @falcon.move_left  if (Gosu.button_down? Gosu::KbLeft)  &&
                          x_next_left  > 0                  &&
                          y_next_left  > 0

    @falcon.move_right if (Gosu.button_down? Gosu::KbRight) &&
                          x_next_right < self.width         &&
                          y_next_right < self.height

    @falcon.move_up    if (Gosu.button_down? Gosu::KbUp)    &&
                          z_next_up    > 0
    @falcon.move_down  if (Gosu.button_down? Gosu::KbDown)  &&
                          z_next_down  < self.height

    # Create Hiero
    if @hiero.length < 3
      @hiero.push(Hiero.new(width, 0, 0)) if (rand 1000) < 2
    end
    

    # Move Hiero
    @hiero.each { |h| h.update }

    # Detect collision
    @hiero.each { |h| @hiero.delete(h) if h.box.x <= 0}
    # if @falcon.overlapsWith(@hiero)
    #   TODO: Do something
    # end

    # TODO: remaining updates
    @fps = Gosu::fps.to_s
        
  end

  def draw
    #puts fps
    @background_image.render(0, 0, 0)
    @font.draw("FPS: #{fps}", (self.width - 80), (self.height - 40), 0xff_ff0000)
    @falcon.draw
    @hiero.each { |h| h.draw }
  end

end
