
require './game_object'


class Grass < GameObject

  def initialize(x, y)
    super(x, y, ImageLoader.load( 'resources/grass.png' ))
  end
end