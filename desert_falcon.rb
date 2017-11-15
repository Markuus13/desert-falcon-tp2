require "bundler"

module DesertFalcon
  def self.start_game
    initial_config

    window = GameWindow.new(640, 480)
    window.show
  end

  def self.initial_config
    # Requires all gems in Gemfile #
    Bundler.require(:default)

    # Put files in $LOAD_PATH global variable #
    %w[lib assets spec].each do |folder_name|
      path = File.expand_path("../#{folder_name}", __FILE__)
      $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
    end
    Dir["./lib/*.rb"].each { |file| require file }
  end
end

DesertFalcon.start_game
