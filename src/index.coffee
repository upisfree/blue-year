import config from './config.coffee'
import editor from './editor.coffee'
import loader from './loader.coffee'
import map from './map.coffee'

# init
window.enities = []

window.app = new PIXI.Application
  width: window.innerWidth
  height: window.innerHeight

document.body.appendChild app.view

PIXI.settings.SCALE_MODE = PIXI.SCALE_MODES.NEAREST

loader ->
  console.log 'resources loaded'

  map()

  if config.editor
    editor()