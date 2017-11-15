require 'gosu'

class GameWindow < Gosu::Window
  MENU = 0
  GAME = 1
  SCORE = 2
  SCOREBOARD = 3

  def initialize(width, height)
    super width, height
    self.caption = "Desert Falcon"
    Random.new_seed

    @background_image = Sprite.new("assets/images/sand_background.jpg")
    @font = Gosu::Font.new(20)
    @falcon = Falcon.new(width/4.0, 3 * height/4.0, 0)
    @hiero = Array.new
    @obstacle = Array.new
    @enemy = Array.new
    @score = 0
    @state = MENU
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @draw_array = [method(:draw_menu), method(:draw_game), method(:draw_score), method(:draw_scoreboard)]
  end

  def quit
    close
  end

  def update
    case @state
    when MENU
      def draw; @draw_array[MENU].call; end
      @state = GAME if Gosu.button_down? Gosu::KB_1
      @state = SCOREBOARD if Gosu.button_down? Gosu::KB_2

    when GAME
      def draw; @draw_array[GAME].call; end
      game_logic

    when SCORE
      self.text_input ||= TextInput.new
      def draw; @draw_array[SCORE].call; end
      @state = SCOREBOARD if text_input.finished?

    when SCOREBOARD
      self.text_input = nil
      def draw; @draw_array[SCOREBOARD].call; end
      initial_state if Gosu.button_down? Gosu::KB_0
    end
  end

  # Game logic
  def game_logic
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
    hiero_spawn_chance = (rand 1000) < 5
    x_next = self.width
    y_next = (rand 200)
    z_next = (rand 3) - 1

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

    # Create Enemy
    enemy_spawn_chance = (rand 1500) < 5
    x_next = self.width
    y_next = (rand 200)
    z_next = (rand 3) - 1

    if @enemy.length < 3
      @enemy.push(Enemy.new(x_next, y_next, z_next)) if enemy_spawn_chance
    end

    # Move Enemy
    @enemy.each { |e| e.update }

    ## Detect collision
    ## Deletes enemy if it collides with border
    @enemy.delete_if { |e| e.box.x <= 0 || e.box.y >= self.height }

    ## Game over if falcon collides with enemy
    @enemy.each do |e|
      end_game if e.notify_collision(@falcon.box) && @falcon.notify_collision(e.box)
    end


    # Create Obstacle
    obstacle_spawn_chance = (rand 500) < 5
    x_next = self.width
    y_next = (rand 200)
    z_next = -1

    if @obstacle.length < 3
      @obstacle.push(Obstacle.new(x_next, y_next, z_next)) if obstacle_spawn_chance
    end

    # Move Obstacle
    @obstacle.each { |o| o.update }

    # Detect collision
    ## Deletes obstacle if it collides with border
    @obstacle.delete_if { |o| o.box.x <= 0 || o.box.y >= self.height }

    ## Game over if falcon collides with obstacle
    @obstacle.each do |o|
      if (o.notify_collision(@falcon.box) && @falcon.notify_collision(o.box))
        @state = SCORE
      end
    end

    # TODO: remaining updates
    @fps = Gosu::fps.to_s
  end

  private

  def button_down(id)
    if id == Gosu::KbEscape
      self.quit
    else
      super
    end
  end

  def initial_state
    @state = MENU
    @score = 0
    @hiero = []
    @obstacle = []
  end

  def draw_menu
    @font.draw("1 - Play", 0, 0, 1, 1.0, 1.0)
    @font.draw("2 - Scoreboard", 0, 30, 1.0, 1.0, 1.0)
    @font.draw("ESC - Quit", 0, 60, 1.0, 1.0, 1.0)
  end

  def draw_game
    @background_image.render(0, 0, 0)
    @font.draw("SCORE: #{@score}", 10, 10, 5, 1, 1, 0xff_00ff00)
    @font.draw("FPS: #{@fps}", (self.width - 80), (self.height - 20), 5, 1, 1, 0xff_00ff00)
    @falcon.draw
    @hiero.each { |h| h.draw }
    @enemy.each { |e| e.draw }
    @obstacle.each { |o| o.draw }
  end

  def draw_scoreboard
    @font.draw("Desert Falcon - Scoreboard", 200, 0, 1, 1.0, 1.0)
    @font.draw("0 - Main Menu", 0, 30, 1, 1.0, 1.0)
  end

  def draw_score
    @font.draw("Desert Falcon", 250, 10, 1, 1.0, 1.0)
    @font.draw("Your score was #{@score}!", 235, 150, 1, 1.0, 1.0)
    @font.draw("Write your name to save your score: #{self.text_input.text}", 160, 180, 1, 1.0, 1.0)
    @font.draw("Press '=' to save your score", 200, 400, 1, 1.0, 1.0)
  end
end
