# Object Oriented Programming: Review Session 1
CodeCore Cohort XI Week 1 review session. Topics to include Classes, Modules, Inheritance, Custom Errors, Markdown, Revisioning.

## Classes: Ball, Ghost, Pacman
Let's take a look at classes and how they interact by modeling out a ball class that may have a type attribute, a ghost class that has a color attribute, and a Pacman class, whose attributes we shall discuss below.  
  
### Ball Class
Create a class `Ball` with a `ball_type` attribute; knowing that `ball_type` will only ever be `regular` or `super`.  
  
Let's start out by creating a ball class that has a getter method for `ball_type`, and a default ball type of `"regular"`
```ruby
class Ball
  def initialize
  end

  def ball_type
  end
end
```
Now, I'd really like to be able to initialize new ball objects with a `ball_type`. So, let's go ahead and add an optional `ball_type` param to the initialize method. We can make it optional by adding a default value. Let's make it default to `"regular".`  
  
We should also initialize an instance variable, so our getter method can return a dynamic value.
```ruby
class Ball
  # constructor method
  def initialize(ball_type = "regular")
    @ball_type = ball_type.downcase == "regular" ? "regular : "super"
  end

  # getter method
  def ball_type
    @ball_type
  end
end
```
### Ghost Class
Let's create a ghost class that initializes with a random color of: red, pink, purple, yellow, and has a getter method to read the color.
```ruby
class Ghost
  # Your code goes here
  def initialize
    @color = %w(red pink purple yellow).sample
  end

  # getter
  def color
    @color
  end
end
```
### Pacman Class
Our Pacman class doesn't have to be very robust. We only need to handle two actions: eating ghosts and balls. We should also consider some attributes, such as points and lives.  
  
Take a moment to think about how we should structure our Pacman class, and maybe start writing some methods.  
  
```ruby
class Pacman
  # Your code goes here

  # What should Pacman initialize with?
  def initialize
    @points, @extra_lives, @power_time = 0, 2, 0
  end

  def eat(something)
    something.class == Ball ? eat_ball(something) : eat_ghost(something)
  end

  private

  def eat_ball(ball)
    @points += 1000 if ball.ball_type == "regular"
    @power_time = 10 if ball.ball_type == "super"
  end

  def eat_ghost(ghost)
    raise StandardError.new("What is that????") unless ghost.class == Ghost
    if @power_time > 0
      @points += 250000
    else
      die
    end
  end

  def die
    @lives -= 1
    game_over if @lives < 0
  end

  def game_over
    100000.times { puts "!!!!!!!!!!!!!!!!!!You Got #{@points} Points!!!!!!!!!!!!!!!!!GAME OVER!!!!!!!!!!!!!!!!!!!" }
  end
end
```
And let's add a setup file for convenience.
```ruby
# setup.rb
require "./pacman.rb"
require "./ball.rb"
require "./ghost.rb"

def setup
  @pacman = Pacman.new
  @regular_ball = Ball.new
  @super_ball = Ball.new("super")
  @ghost1 = Ghost.new
  @ghost2 = Ghost.new
  @ghost3 = Ghost.new
  @ghost4 = Ghost.new

  puts "Welcome to Pacman"
  puts "You have #{@pacman.extra_lives} lives."
end

def play_through
  10.times { @pacman.eat(@regular_ball) } # points should equal 10000
  puts "You have #{@pacman.points} points."
  @pacman.eat(@ghost1) # extra lives should decrease by 1 (eq: 1)
  puts "You have #{@pacman.extra_lives} lives."
  @pacman.eat(@super_ball) # set super_time to 10
  puts "You ate a super ball. super_time: #{@pacman.super_time}."
  @pacman.eat(@ghost2)
  @pacman.eat(@ghost3)
  @pacman.eat(@ghost4)
  puts "You have #{@pacman.points} points!"
  10.times { @pacman.eat(@regular_ball) } # super_time should be less than zero
  @pacman.eat(@ghost1)
  puts "You have #{@pacman.extra_lives} lives and #{@pacman.points} points."
end
```
