# Generated at Tue, 19 Dec 2017 15:35:55 GMT
import Bed from './enities/bed.coffee'
import Player from './enities/player.coffee'
import Clock from './enities/clock.coffee'
import Furnace from './enities/furnace.coffee'

map = ->
  e0 = new Furnace()
  e0.sprite.position.set 757, 1001
  e0.sprite.scale.set 1
  e0.sprite.rotation = 3.141592653589793

  e1 = new Clock()
  e1.sprite.position.set 1400, 861
  e1.sprite.scale.set 7
  e1.sprite.rotation = 6.283185307179586

  e2 = new Player()
  e2.sprite.position.set 691, 240
  e2.sprite.scale.set 6
  e2.sprite.rotation = 0.7853981633974483

  e3 = new Bed()
  e3.sprite.position.set 214, 496
  e3.sprite.scale.set 7
  e3.sprite.rotation = 7.0685834705770345

  e4 = new Clock()
  e4.sprite.position.set 1396, 250
  e4.sprite.scale.set 8
  e4.sprite.rotation = 0

  e5 = new Clock()
  e5.sprite.position.set 1530, 242
  e5.sprite.scale.set 8
  e5.sprite.rotation = 0

  e6 = new Clock()
  e6.sprite.position.set 839, 716
  e6.sprite.scale.set 6
  e6.sprite.rotation = 0

  e7 = new Player()
  e7.sprite.position.set 473, 712
  e7.sprite.scale.set 7
  e7.sprite.rotation = 3.9269908169872414

  e8 = new Furnace()
  e8.sprite.position.set 1991, 408
  e8.sprite.scale.set 8
  e8.sprite.rotation = 6.283185307179586

export default map