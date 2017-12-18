class Enity
  constructor: (texture, x = app.renderer.width / 2, y = app.renderer.height / 2) ->
    if Array.isArray texture
      @sprite = new PIXI.extras.AnimatedSprite texture
    else
      @sprite = new PIXI.Sprite texture

    @sprite.x = x
    @sprite.y = y
    
    # default
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5

    @sprite.enity = @

    app.stage.addChild @sprite
    enities.push @

export default Enity