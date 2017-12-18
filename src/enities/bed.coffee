import Enity from '../enity.coffee'

class Bed extends Enity
  constructor: (x, y) ->
    super resources.sprite_bed.texture, x, y

export default Bed