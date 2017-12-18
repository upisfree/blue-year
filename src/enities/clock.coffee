import Enity from '../enity.coffee'

class Clock extends Enity
  constructor: (x, y) ->
    t = []

    for i in [0..2]
      t.push PIXI.Texture.fromFrame 'clock-' + (i + 1) + '.png'

    super t, x, y

    @sprite.animationSpeed = 0.05
    @sprite.gotoAndPlay 0


export default Clock