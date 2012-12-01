define((require) -> 
  entities = require('entities')

  global.FIELD_MAX_X = 416
  global.FIELD_MAX_Y = 464
  global.FIELD_X = 32
  global.FIELD_Y = 16
  global.PAD_MAX = 16     # max number of pad key

  global.ch = {}          # player characator info
  global.enemy = []

  configKey = () ->
    input = me.input
    input.bindKey(input.KEY.LEFT, "left")
    input.bindKey(input.KEY.RIGHT, "right")
    input.bindKey(input.KEY.UP, "up")
    input.bindKey(input.KEY.DOWN, "down")

    input.bindKey(input.KEY.Z, "shot")
    input.bindKey(input.KEY.X, "bomb")
    input.bindKey(input.KEY.SHIFT, "slow")


  return () ->
    configKey()
    # initialize the player characator
    return 
)