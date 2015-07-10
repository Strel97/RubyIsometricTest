
require './game_object'
require './player'


class ObjectFactory

  FACTORY_METHODS = [

      Proc.new { |x, y|
      },

      Proc.new { |x, y|
        Player.new(x, y)
      },
  ]

  OBJECTS_CNT = 2


  def create( id, x, y )
    if id < 0 or id > OBJECTS_CNT
      return
    end

    # creates tile
    FACTORY_METHODS[id].call(x, y)
  end
end