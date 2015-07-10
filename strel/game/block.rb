
require './game_object'


class Block < GameObject

  def initialize(x, y)
    super(x, y, ImageLoader.load( 'resources/block.png' ))
  end
end