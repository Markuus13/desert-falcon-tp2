module DesertFalcon
  def self.start_game
    window = GameWindow.new(640, 480)
    window.show
  end

  def self.initial_config
    %w(lib assets).each do |folder_name|
      path = File.expand_path("../#{folder_name}", __FILE__)
      $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
    end
    Dir["./lib/*.rb"].each { |file| require file }
  end
end

DesertFalcon::initial_config
DesertFalcon::start_game
