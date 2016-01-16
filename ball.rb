class Ball
  # constructor method
  def initialize(ball_type = "regular")
    @ball_type = ball_type.downcase == "regular" ? ball_type : "super"
  end

  # getter method
  def ball_type
    @ball_type
  end
end
