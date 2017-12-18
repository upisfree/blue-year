import config from './config.coffee'

res = 
  sprites: ['player', 'table', 'furnace', 'bed']
  animations: ['clock']

loader = (callback) ->
  for s in res.sprites
    PIXI.loader.add "sprite_#{s}", "#{config.path.textures}/#{s}.png" 

  for a in res.animations
    PIXI.loader.add "animation_#{a}", "#{config.path.textures}/#{a}.json" 

  PIXI.loader.load (loader, resources) =>
    window.resources = resources

    callback()

export default loader