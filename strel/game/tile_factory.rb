require './game_object'
require './block'
require './grass'


class TileFactory

  #
  # This maps to every type of
  # factory method id of object
  # that it creates.
  #
  # So, we can use it in Map class
  # like this TileFactory.create( id )
  #
  # This feature is used to avoid
  # switch statements
  #
  FACTORY_METHODS = [

      Proc.new { |x, y|
        Grass.new(x, y)
      },

      Proc.new { |x, y|
        Block.new(x, y)
      },

      Proc.new { |x, y|
        GameObject.new(x, y)
      },
  ]

  OBJECTS_CNT = 3


  def initialize
  end

  def create( id, x, y )
    if id < 0 or id > OBJECTS_CNT
      return
    end

    # creates tile
    FACTORY_METHODS[id].call(x, y)
  end
end