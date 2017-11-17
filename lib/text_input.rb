class TextInput < Gosu::TextInput
  def initialize
    super
  end

  def filter(text_in)
    @last_char = text_in
    return if text.length > 2
    text_in.gsub(/[^a-zA-Z0-9]/, "").upcase
  end

  def finished?
    @last_char == "=" && !text.empty?
  end
end
