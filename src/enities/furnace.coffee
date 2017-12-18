import Enity from '../enity.coffee'

class Furnace extends Enity
  constructor: (x, y) ->
    super resources.sprite_furnace.texture, x, y

export default Furnace