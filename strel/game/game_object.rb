
require './image_loader'


class GameObject

  DEFAULT_SCALE = 5


  def initialize(x, y, img=ImageLoader.load('resources/empty.png') )
    @x = x
    @y = y
    @img = img
  end

  def draw
    @img.draw(@x, @y, 0, DEFAULT_SCALE, DEFAULT_SCALE)
  end
end