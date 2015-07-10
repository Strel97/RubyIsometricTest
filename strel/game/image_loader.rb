
require 'gosu'


class ImageLoader

  def ImageLoader.load( source )
    return Gosu::Image.new(source, :tileable => true)
  end

end