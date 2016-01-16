class Pacman
  attr_reader :extra_lives, :points, :super_time

  def initialize
    @extra_lives, @points, @super_time = 2, 0, 0
  end

  def eat(ball_or_ghost)
    ball_or_ghost.class == Ball ? eat_ball(ball_or_ghost) : eat_ghost(ball_or_ghost)
  end

  private

  def eat_ball(ball)
    @super_time -= 1
    @points += 1000 if ball.ball_type == "regular"
    @super_time = 10 if ball.ball_type == "super"
  end

  def eat_ghost(ghost)
    raise PacmanErrors::BadFoodError.new("Don't feed me that!!!") unless ghost.class == Ghost
    @super_time > 0 ? @points += 250000 : die
  end

  def die
    @extra_lives -= 1
    game_over if @extra_lives < 0
  end

  def game_over
    10000.times { puts "!!!!!!!!!!POINTS: #{@points}!!!!!!!!!!GAME OVER!!!!!!!!!!" }
  end
end

module PacmanErrors
  class BadFoodError < StandardError; end
  class ThatAintNoGhost < BadFoodError; end
  class LoLWhat; end
end
