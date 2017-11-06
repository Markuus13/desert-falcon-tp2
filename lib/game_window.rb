require 'gosu'

class GameWindow < Gosu::Window

  def initialize(width, height)
    super width, height
    self.caption = "Desert Falcon"
    Random.new_seed

    # TODO: load images with Sprite
    @background_image = Sprite.new("assets/images/sand_background.jpg")
    @font = Gosu::Font.new(20)
    @falcon = Falcon.new(width/4.0, 3 * height/4.0, 0)
    @hiero = Array.new
    @obstacle = Array.new
    @score = 0
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
    x_next = self.width
    y_next = self.height / 3
    z_next = (rand 3) - 1
    hiero_spawn_chance = (rand 1000) < 5

    if @hiero.length < 3
      @hiero.push(Hiero.new(x_next, y_next, z_next)) if hiero_spawn_chance
    end

    # Move Hiero
    @hiero.each { |h| h.update }

    # Detect collision
    ## Delete hiero if it collides with border
    @hiero.delete_if { |h| h.box.x <= 0 || h.box.y >= self.height }

    ## Delete hiero it it collides with falcon
    @hiero.delete_if { |h|
      h.notify_collision(@falcon.box) &&
      @falcon.notify_collision(h.box) &&
      @score += 10
    }

    # Create Obstacle
    obstacle_spawn_chance = (rand 500) < 5
    x_next = self.width
    y_next = (rand 200)
    z_next = 0

    if @obstacle.length < 3
      @obstacle.push(Obstacle.new(x_next, y_next, z_next)) if obstacle_spawn_chance
    end

    # Move Obstacle
    @obstacle.each { |o| o.update }

    # Detect collision
    ## Deletes obstacle if it collides with border
    @obstacle.delete_if { |o| o.box.x <= 0 || o.box.y >= self.height }

    ## Game over if falcon collides with obstacle

    # TODO: remaining updates
    @fps = Gosu::fps.to_s

  end

  def draw
    @background_image.render(0, 0, 0)
    @font.draw("SCORE: #{@score}", 10, 10, 5, 1, 1, 0xff_00ff00)
    @font.draw("FPS: #{@fps}", (self.width - 80), (self.height - 20), 5, 1, 1, 0xff_00ff00)
    @falcon.draw
    @hiero.each { |h| h.draw }
    @obstacle.each { |o| o.draw }
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
