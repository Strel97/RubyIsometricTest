
require './game_object'


class Player < GameObject

  # Types of directions, available for player.
  # Array represents direction velocities:
  # first element is dx and second is dy
  DIRECTIONS = [
      [-1, -1],    # North
      [-1,  1],    # West
      [1,   1],    # South
      [1,  -1]     # East
  ]

  NORTH   = 0
  WEST    = 1
  SOUTH   = 2
  EAST    = 3

  DX = 0
  DY = 1


  attr_reader :x, :y


  def initialize(x, y)
    super(x, y, ImageLoader.load( 'resources/player.png' ))
  end

  # No switch!!!
  def step( direction )
    @x += DIRECTIONS[direction][DX]
    @y += DIRECTIONS[direction][DY]
  end

  def draw
    @img.draw(@x + 8 * DEFAULT_SCALE, @y - 8 * DEFAULT_SCALE, 0, DEFAULT_SCALE, DEFAULT_SCALE)
  end
end