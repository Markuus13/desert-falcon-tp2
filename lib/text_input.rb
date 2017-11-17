class TextInput < Gosu::TextInput
  # Initialize TextInput object that inherits Gosu::TextInput
  def initialize
    super
  end

  # Overriden method of Gosu::TextInput to filter if a string is valid or not.
  # Invalid string are not captured. Valid strings are numbers and letters.
  # @param text_in [String] the string written by the user
  # @return [String] filtered string
  def filter(text_in)
    @last_char = text_in
    return if text.length > 2
    text_in.gsub(/[^a-zA-Z0-9]/, "").upcase
  end

  # Returns true if the user has pressed the '=' character that represents
  # end of input on this game.
  # @return [Boolean] if user finished filling the input
  def finished?
    @last_char == "=" && !text.empty?
  end
end
