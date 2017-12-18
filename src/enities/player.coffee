import config from '../config.coffee'
import Enity from '../enity.coffee'

step = 10

class Player extends Enity
  constructor: (x, y) ->
    super resources.sprite_player.texture, x, y

    window.onkeydown = (e) =>
      switch e.keyCode
        when 87, 38 # up
          @sprite.y -= step
        when 83, 40 # down
          @sprite.y += step
        when 68, 39 # right
          @sprite.x += step
        when 65, 37 # left
          @sprite.x -= step

export default Player