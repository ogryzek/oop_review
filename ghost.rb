class Ghost
  # constructor
  def initialize
    @color = %w(red purple yellow pink).sample
  end

  # getter
  attr_reader :color
  # def color
  #   @color
  # end
end
