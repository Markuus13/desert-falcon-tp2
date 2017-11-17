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

  def game_logic
    falcon_input
    handle_hieros
    handle_enemies
    handle_obstacles
    gosu_fps
  end

  private

  def gosu_fps
    @fps = Gosu.fps.to_s
  end

  def quit
    close
  end

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
    @hieros = []
    @obstacles = []
    @enemies = []
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
    @hieros.each(&:draw)
    @enemies.each(&:draw)
    @obstacles.each(&:draw)
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

  def falcon_input
    @falcon.move_left  if (Gosu.button_down? Gosu::KbLeft) && move_left_possible?(@falcon.box)
    @falcon.move_right if (Gosu.button_down? Gosu::KbRight) && move_right_possible?(@falcon.box)
    @falcon.move_up    if (Gosu.button_down? Gosu::KbUp) && move_up_possible?(@falcon.box)
    @falcon.move_down  if (Gosu.button_down? Gosu::KbDown) && move_down_possible?(@falcon.box)
  end

  def move_left_possible?(falcon_box)
    x_next_left = falcon_box.x - @falcon.x_vel
    y_next_left = falcon_box.y - @falcon.y_vel
    (x_next_left > 0) && (y_next_left > 0)
  end

  def move_right_possible?(falcon_box)
    x_next_right = falcon_box.x + falcon_box.width + @falcon.x_vel
    y_next_right = falcon_box.y + falcon_box.height + @falcon.y_vel
    (x_next_right < width) && (y_next_right < height)
  end

  def move_up_possible?(falcon_box)
    z_next_up = falcon_box.y - @falcon.z_vel
    z_next_up > 0
  end

  def move_down_possible?(falcon_box)
    z_next_down = falcon_box.y + falcon_box.height + @falcon.z_vel
    z_next_down < height
  end

  def handle_hieros
    # Create Hiero
    hiero_spawn_chance = (rand 1000) < 5
    x_next = width
    y_next = (rand 200)
    z_next = (rand 3) - 1

    if @hieros.length < 3
      @hieros.push(Hiero.new(x_next, y_next, z_next)) if hiero_spawn_chance
    end

    # Move Hiero
    @hieros.each(&:update)

    # Detect collision
    ## Delete hiero if it collides with border
    @hieros.delete_if { |hiero| hiero.box.x <= 0 || hiero.box.y >= height }

    ## Delete hiero if it collides with falcon
    @hieros.delete_if do |hiero|
      hiero.notify_collision(@falcon.box) &&
        @falcon.notify_collision(hiero.box) &&
        @score += 10
    end
  end

  def handle_enemies
    # Create Enemy
    enemy_spawn_chance = (rand 1500) < 5
    x_next = width
    y_next = (rand 200)
    z_next = (rand 3) - 1

    if @enemies.length < 3
      @enemies.push(Enemy.new(x_next, y_next, z_next)) if enemy_spawn_chance
    end

    # Move Enemy
    @enemies.each(&:update)

    ## Detect collision
    ## Deletes enemy if it collides with border
    @enemies.delete_if { |enemy| enemy.box.x <= 0 || enemy.box.y >= height }

    ## Game over if falcon collides with enemy
    @enemies.each do |enemy|
      @state = SCORE if enemy.notify_collision(@falcon.box) && @falcon.notify_collision(enemy.box)
    end
  end

  def handle_obstacles
    # Create Obstacle
    obstacle_spawn_chance = (rand 500) < 5
    x_next = width
    y_next = (rand 200)
    z_next = -1

    if @obstacles.length < 3
      @obstacles.push(Obstacle.new(x_next, y_next, z_next)) if obstacle_spawn_chance
    end

    # Move Obstacle
    @obstacles.each(&:update)

    # Detect collision
    ## Deletes obstacle if it collides with border
    @obstacles.delete_if { |obstacle| obstacle.box.x <= 0 || obstacle.box.y >= height }

    ## Game over if falcon collides with obstacle
    @obstacles.each do |obstacle|
      @state = SCORE if obstacle.notify_collision(@falcon.box) && @falcon.notify_collision(obstacle.box)
    end
  end
end
