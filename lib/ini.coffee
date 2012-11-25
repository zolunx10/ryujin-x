define((require) -> 
  entities = require('entities')

  global.FIELD_MAX_X = 384
  global.FIELD_MAX_Y = 448
  global.FIELD_X = 32
  global.FIELD_Y = 16
  global.PAD_MAX = 16     # max number of pad key

  global.ch = {}          # player characator info

  configKey = () ->
    input = me.input
    input.bindKey(input.KEY.LEFT, "left")
    input.bindKey(input.KEY.RIGHT, "right")

    input.bindKey(input.KEY.Z, "shot")
    input.bindKey(input.KEY.SHIFT, "slow")


  return () ->
    configKey()
    # initialize the player characator
    global.ch = new entities.PlayerCharacator(global.FIELD_MAX_X/2, global.FIELD_MAX_Y*3/4, {})
    return 
)