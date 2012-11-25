define({
  PlayerCharacator: me.ObjectEntity.extend({
    init: (x,y,settings)->
      settings = settings || {}
      settings.name = "Player"
      settings.image = "char"
      settings.spritewidth = 73
      settings.spriteheight = 73
      this.parent(x, y, settings)

      this.addAnimation("norm", [0, 1, 2, 3])

      this.setCurrentAnimation("norm")

    update: () ->
      isKey = me.input.isKeyPressed
      this.parent()
      
  })
})