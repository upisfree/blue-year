# simple map editor
# usage: start server by `node editor/editor.js`, click on enity and press the key
# R: rotate 45 degrees
# 1-9: set scaleimport config from './config.coffee'

import Clock from './enities/clock.coffee'
import Furnace from './enities/furnace.coffee'
import Bed from './enities/bed.coffee'
import Player from './enities/player.coffee'

_all =
  'Player': Player
  'Clock': Clock
  'Bed': Bed
  'Furnace': Furnace

# events
onDragStart = (event) ->
  # store a reference to the data
  # the reason for this is because of multitouch
  # we want to track the movement of this particular touch
  this.data = event.data
  this.alpha = 0.5
  this.dragging = true

  window.currentEditorElement = this

onDragEnd = ->
  this.alpha = 1
  this.dragging = false
  # set the interaction data to null
  this.data = null

  window.currentEditorElement = null

  saveMap()

onDragMove = ->
  if this.dragging
    newPosition = this.data.getLocalPosition this.parent
    this.x = newPosition.x
    this.y = newPosition.y

onRightClick = (e) ->
  p = e.data.getLocalPosition this.parent
  c = new _all[this.enity.constructor.name](p.x, p.y)
  c.sprite.scale = this.scale
  c.sprite.rotation = this.rotation

  initEditorForSprite c

  # if enity use window.onkeydown
  window.onkeydown = keyboardManager



keyboardManager = (e) ->
  c = window.currentEditorElement

  console.log e.keyCode

  if c
    switch e.keyCode
      when 82
        c.rotation += Math.PI / 4
      when 49, 50, 51, 52, 53, 54, 55, 56, 57
        c.scale.set e.keyCode - 48

initEditorForSprite = (e) ->
  e.sprite.interactive = true
  e.sprite.buttonMode = true

  e.sprite.on 'pointerdown', onDragStart
   .on 'pointerup', onDragEnd
   .on 'pointerupoutside', onDragEnd
   .on 'pointermove', onDragMove
   .on 'rightclick', onRightClick

mapToCode = ->
  s = '\nmap = ->\n'
  usedEnities = []
  i = 0

  for e in enities
    if usedEnities.indexOf(e.constructor.name) is -1
      usedEnities.push e.constructor.name

      s = "import #{e.constructor.name} from './enities/#{e.constructor.name.toLowerCase()}.coffee'\n" + s

    s += "  e#{i} = new #{e.constructor.name}()\n"
    s += "  e#{i}.sprite.position.set #{e.sprite.position.x}, #{e.sprite.position.y}\n"
    s += "  e#{i}.sprite.scale.set #{e.sprite.scale.x}\n" # x = y
    s += "  e#{i}.sprite.rotation = #{e.sprite.rotation}\n\n"

    i++

  s = "# Generated at #{new Date().toUTCString()}\n" + s
  s += 'export default map'

  return s

saveMap = ->
  s = mapToCode()

  xhr = new XMLHttpRequest()
  xhr.open 'POST', 'http://localhost:1488', true
  xhr.send s

  xhr.onreadystatechange = ->
    if xhr.status is 200 and xhr.readyState is 4
      console.log xhr.responseText

editor = ->
  app.view.oncontextmenu = ->
    return false

  window.onkeydown = keyboardManager
  window.currentEditorElement = null # global i mne pohuy

  for e in enities
    initEditorForSprite e

export default editor