
require 'gosu'
require './map'


class GameWindow < Gosu::Window
  def initialize
    super 1000, 500
    self.caption = 'Isometric Graphics Test'

    @tile_map = Map.new
  end

  def update
    @tile_map.update
  end

  def draw
    @tile_map.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end


window = GameWindow.new
window.show