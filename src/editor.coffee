# simple map editor
# usage: start server by `node editor/editor.js`, click on enity and press the key
# R: rotate 45 degrees
# 1-9: set scaleimport config from './config.coffee'

import Clock from './enities/clock.coffee'
import Furnace from './enities/furnace.coffee'
import Bed from './enities/bed.coffee'
import Player from './enities/player.coffee'

AllEnities =
  'Player': Player
  'Clock': Clock
  'Bed': Bed
  'Furnace': Furnace

# events
enityOnDragStart = (e) ->
  # store a reference to the data
  # the reason for this is because of multitouch
  # we want to track the movement of this particular touch
  this.data = e.data
  this.alpha = 0.5
  this.dragging = true

  window.currentEditorElement = this

enityOnDragEnd = ->
  this.alpha = 1
  this.dragging = false
  this.enity.editorsControl = false
  this.data = null

  window.currentEditorElement = null
  window.onkeydown = keyboardManager

  saveMap()

enityOnDragMove = ->
  if this.dragging
    newPosition = this.data.getLocalPosition this.parent
    this.x = newPosition.x
    this.y = newPosition.y

enityOnRightClick = (e) ->
  p = e.data.getLocalPosition this.parent
  c = new AllEnities[this.enity.constructor.name](p.x, p.y)
  c.sprite.scale = this.scale
  c.sprite.rotation = this.rotation

  addEditorsEventsToEnity c

  # if enity use window.onkeydown
  window.onkeydown = keyboardManager

controlOnDragStart = (e) ->
  c = new AllEnities[this.enity.constructor.name](this.position.x, this.position.y)
  addEditorsEventsToControl c

  this.data = e.data
  this.alpha = 0.5
  this.anchor.set 0.5
  this.dragging = true

  this.off 'pointerdown', controlOnDragStart

  addEditorsEventsToEnity this.enity

  window.currentEditorElement = this
  window.onkeydown = keyboardManager


keyboardManager = (e) ->
  c = window.currentEditorElement

  # console.log e.keyCode

  if c
    switch e.keyCode
      # rotate
      when 82
        c.rotation += Math.PI / 4
      # scale
      when 49, 50, 51, 52, 53, 54, 55, 56, 57
        c.scale.set e.keyCode - 48
      # delete
      when 8, 46
        enities.splice enities.indexOf(c.enity), 1
        app.stage.removeChild c

addEditorsEventsToEnity = (e) ->
  e.sprite.interactive = true
  e.sprite.buttonMode = true
  e.editorsControl = false

  e.sprite.on 'pointerdown', enityOnDragStart
   .on 'pointerup', enityOnDragEnd
   .on 'pointerupoutside', enityOnDragEnd
   .on 'pointermove', enityOnDragMove
   .on 'rightclick', enityOnRightClick
   .on 'removed', enityOnDragEnd

addEditorsEventsToControl = (e) ->
  e.sprite.interactive = true
  e.sprite.buttonMode = true
  e.editorsControl = true
  e.sprite.anchor.set 0

  e.sprite.on 'pointerdown', controlOnDragStart
   .on 'pointermove', enityOnDragMove

# code generate
mapToCode = ->
  s = '\nmap = ->\n'
  usedEnities = []
  i = 0

  for e in enities
    if not e.editorsControl
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


# editor controls
addEnitiesPanel = ->
  x = 10
  y = 10
  margin = 10

  for k, v of AllEnities
    c = new v x, y
    addEditorsEventsToControl c

    x += c.sprite.width + margin

# init
editor = ->
  app.view.oncontextmenu = ->
    return false

  window.currentEditorElement = null # global i mne pohuy

  addEnitiesPanel()

  for e in enities
    if not e.editorsControl
      addEditorsEventsToEnity e

  window.onkeydown = keyboardManager

export default editor