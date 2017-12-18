# Generated at Mon, 18 Dec 2017 02:50:16 GMT
import Player from './enities/player.coffee'
import Bed from './enities/bed.coffee'

map = ->
  e0 = new Bed()
  e0.sprite.position.set 288, 528
  e0.sprite.scale.set 7
  e0.sprite.rotation = 0.7853981633974483

  e1 = new Player()
  e1.sprite.position.set 1421, 864
  e1.sprite.scale.set 9
  e1.sprite.rotation = 2.356194490192345

export default map