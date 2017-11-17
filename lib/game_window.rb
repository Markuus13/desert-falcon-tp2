require "gosu"

class GameWindow < Gosu::Window
  MENU = 0
  GAME = 1
  SCORE = 2
  SCOREBOARD = 3

  def initialize(width, height)
    super width, height
    Random.new_seed

    self.caption = "Desert Falcon"
    @background_image = Sprite.new("assets/images/sand_background.jpg")
    @falcon = Falcon.new(width / 4.0, 3 * height / 4.0, 0)
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
    @draw_methods = [method(:draw_menu), method(:draw_game), method(:draw_score),
                     method(:draw_scoreboard)]
    initial_state
  end

  def draw
    @draw_methods[@state].call
  end

  def update
    case @state
    when MENU
      menu
    when GAME
      game_logic
    when SCORE
      score
    when SCOREBOARD
      scoreboard
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
        x_next_left  > 0 &&
        y_next_left  > 0

    @falcon.move_right if (Gosu.button_down? Gosu::KbRight) &&
        x_next_right < width &&
        y_next_right < height

    @falcon.move_up    if (Gosu.button_down? Gosu::KbUp)    &&
        z_next_up > 0
    @falcon.move_down  if (Gosu.button_down? Gosu::KbDown)  &&
        z_next_down < height

    # Create Hiero
    hiero_spawn_chance = (rand 1000) < 5
    x_next = width
    y_next = (rand 200)
    z_next = (rand 3) - 1

    if @hiero.length < 3
      @hiero.push(Hiero.new(x_next, y_next, z_next)) if hiero_spawn_chance
    end

    # Move Hiero
    @hiero.each(&:update)

    # Detect collision
    ## Delete hiero if it collides with border
    @hiero.delete_if { |h| h.box.x <= 0 || h.box.y >= height }

    ## Delete hiero it it collides with falcon
    @hiero.delete_if do |h|
      h.notify_collision(@falcon.box) &&
        @falcon.notify_collision(h.box) &&
        @score += 10
    end

    # Create Enemy
    enemy_spawn_chance = (rand 1500) < 5
    x_next = width
    y_next = (rand 200)
    z_next = (rand 3) - 1

    if @enemy.length < 3
      @enemy.push(Enemy.new(x_next, y_next, z_next)) if enemy_spawn_chance
    end

    # Move Enemy
    @enemy.each(&:update)

    ## Detect collision
    ## Deletes enemy if it collides with border
    @enemy.delete_if { |e| e.box.x <= 0 || e.box.y >= height }

    ## Game over if falcon collides with enemy
    @enemy.each do |e|
      @state = SCORE if e.notify_collision(@falcon.box) && @falcon.notify_collision(e.box)
    end

    # Create Obstacle
    obstacle_spawn_chance = (rand 500) < 5
    x_next = width
    y_next = (rand 200)
    z_next = -1

    if @obstacle.length < 3
      @obstacle.push(Obstacle.new(x_next, y_next, z_next)) if obstacle_spawn_chance
    end

    # Move Obstacle
    @obstacle.each(&:update)

    # Detect collision
    ## Deletes obstacle if it collides with border
    @obstacle.delete_if { |o| o.box.x <= 0 || o.box.y >= height }

    ## Game over if falcon collides with obstacle
    @obstacle.each do |o|
      if o.notify_collision(@falcon.box) && @falcon.notify_collision(o.box)
        @state = SCORE
      end
    end

    # TODO: remaining updates
    @fps = Gosu.fps.to_s
  end

  def quit
    close
  end

  private

  def button_down(id)
    if id == Gosu::KbEscape
      quit
    else
      super
    end
  end

  def initial_state
    @state = MENU
    @score = 0
    @hiero = []
    @obstacle = []
    @enemy = []
  end

  def draw_menu
    @font.draw("1 - Play", 0, 0, 1, 1.0, 1.0)
    @font.draw("2 - Scoreboard", 0, 30, 1.0, 1.0, 1.0)
    @font.draw("ESC - Quit", 0, 60, 1.0, 1.0, 1.0)
  end

  def draw_game
    @background_image.render(0, 0, 0)
    @font.draw("SCORE: #{@score}", 10, 10, 5, 1, 1, 0xff_00ff00)
    @font.draw("FPS: #{@fps}", (width - 80), (height - 20), 5, 1, 1, 0xff_00ff00)
    @falcon.draw
    @hiero.each(&:draw)
    @enemy.each(&:draw)
    @obstacle.each(&:draw)
  end

  def draw_scoreboard
    @font.draw("Desert Falcon - Scoreboard", 200, 0, 1, 1.0, 1.0)
    @font.draw("0 - Main Menu", 0, 30, 1, 1.0, 1.0)
    x = 10
    y = 30
    @ranking.all_scores.each do |rank|
      @font.draw(rank.chomp, x, y += 20, 1, 1.0, 1.0)
    end
  end

  def draw_score
    self.text_input ||= TextInput.new
    @font.draw("Desert Falcon", 250, 10, 1, 1.0, 1.0)
    @font.draw("Your score was #{@score}!", 235, 150, 1, 1.0, 1.0)
    @font.draw("Write your name to save your score: #{text_input.text}", 160, 180, 1, 1.0, 1.0)
    @font.draw("Press '=' to save your score", 200, 400, 1, 1.0, 1.0)
  end

  def menu
    @state = GAME if Gosu.button_down? Gosu::KB_1
    @state = SCOREBOARD if Gosu.button_down? Gosu::KB_2
  end

  def score
    if text_input.finished?
      @ranking = Ranking.new
      @ranking.save(text_input.text, @score)
      @state = SCOREBOARD
    end
  end

  def scoreboard
    self.text_input = nil
    initial_state if Gosu.button_down? Gosu::KB_0
  end
end
