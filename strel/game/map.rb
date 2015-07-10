
require 'gosu'

require './tile_factory'
require './object_factory'
require './player'


#
# Contains map with all available tiles.
# 1 - is block
# 0 - is grass
#
class Map
  attr_reader :tile_map, :obj_map

  def initialize
    tile_map = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]

    obj_map = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    @player = Player.new( 500, 250 )

    parse_tile_map(tile_map)
    parse_obj_map(obj_map)

    @font = Gosu::Font.new(15)
  end

  def parse_tile_map(map)
    tile_factory = TileFactory.new
    @tile_map = Array.new

    i = 0
    j = 0

    map.each do |line|

      line_arr = Array.new
      line.each do |digit|

        # Coordinates in cartesian coord system
        cart_x = i * 7 * GameObject::DEFAULT_SCALE
        cart_y = j * 7 * GameObject::DEFAULT_SCALE

        # We translate them to isometric
        # Maybe I should put it to another class
        x = cart_x - cart_y + 450
        y = (cart_x + cart_y) / 2 + 25

        line_arr << tile_factory.create(digit, x, y)

        i += 1
      end

      @tile_map << line_arr

      i = 0
      j += 1
    end
  end


  def parse_obj_map( map )
    obj_factory = ObjectFactory.new
    @obj_map = Array.new

    i = 0
    j = 0

    map.each do |line|

      line_arr = Array.new
      line.each do |digit|

        # Coordinates in cartesian coord system
        cart_x = i * 7 * GameObject::DEFAULT_SCALE
        cart_y = j * 7 * GameObject::DEFAULT_SCALE

        # We translate them to isometric
        # Maybe I should put it to another class
        x = cart_x - cart_y + 450
        y = (cart_x + cart_y) / 2 + 25

        line_arr << obj_factory.create( digit, x, y )

        i += 1
      end

      @obj_map << line_arr

      i = 0
      j += 1
    end
  end

  def coord_to_cell( x, y )
    cart_x = x / 2 + y - 250
    cart_y = y - x / 2 + 200

    cell_x = cart_x / (7 * GameObject::DEFAULT_SCALE)
    cell_y = cart_y / (7 * GameObject::DEFAULT_SCALE)

    # Represents cell coords
    [cell_x, cell_y]
  end

  def update
    old_cell = coord_to_cell( @player.x, @player.y )

    if Gosu::button_down? Gosu::KbLeft
      @player.step( Player::WEST )
    end

    if Gosu::button_down? Gosu::KbRight
      @player.step( Player::EAST )
    end

    if Gosu::button_down? Gosu::KbUp
      @player.step( Player::NORTH )
    end

    if Gosu::button_down? Gosu::KbDown
      @player.step( Player::SOUTH )
    end

    new_cell = coord_to_cell(@player.x, @player.y)

    @obj_map[old_cell[0]][old_cell[1]] = nil
    @obj_map[new_cell[0]][new_cell[1]] = @player
  end

  def draw
    obj_map_i = 0
    obj_map_j = 0

    @tile_map.each do |line|
      line.each do |tile|
        tile.draw
        @obj_map[obj_map_i][obj_map_j].draw unless @obj_map[obj_map_i][obj_map_j].nil?

        obj_map_j += 1
      end

      obj_map_i += 1
      obj_map_j = 0
    end

    player_cell = coord_to_cell(@player.x, @player.y)
    @font.draw( "PLAYER_X=#{@player.x}  PLAYER_Y=#{@player.y}", 10, 10, 0)
    @font.draw( "CELL_X=#{player_cell[0]}  CELL_Y=#{player_cell[1]}", 10, 20, 0)
  end
end