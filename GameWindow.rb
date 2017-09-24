require 'gosu'


class GameWindow < Gosu::Window
  public

  def initialize(width, height)
    super width, height
    self.caption = "Desert Falcon v0.0.0"

    @background_image = Gosu::Image.new("assets/images/grass_background.png")
  end

  def quit
    close
  end

  def update
    if Gosu.button_down? Gosu::KbLeft
      puts "KEY_LEFT"
    end
    if Gosu.button_down? Gosu::KbRight
      puts "KEY_RIGHT"
    end
    if Gosu.button_down? Gosu::KbUp
      puts "KEY_UP"
    end
    if Gosu.button_down? Gosu::KbDown
      puts "KEY_DOWN"
    end
        
  end

  def draw
    @background_image.draw(0, 0, 0)
  end

  private

  def button_down(id)
    if id == Gosu::KbEscape
      self.quit
    else
      super
    end
  end

end


window = GameWindow.new(640, 480)
window.show
