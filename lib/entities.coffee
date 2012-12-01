define((require) -> 
  checkMapCollision = () ->
    # ensure player is in stage area
    obj = this.collisionBox
    pv = this.vel
    x = if pv.x < 0 then obj.left + pv.x else obj.right + pv.x
    y = if pv.y < 0 then obj.top + pv.y else obj.bottom + pv.y
    if (x <= global.FIELD_X || x >= global.FIELD_MAX_X) 
      this.vel.x = 0
    if (y <= global.FIELD_Y || y >= global.FIELD_MAX_Y) 
      this.vel.y = 0

  EnemyTemplate = me.ObjectEntity.extend({
    init: (x,y,settings) ->
      this.parent(x,y,settings)
      this.wait = settings.wait
      this.sp   = settings.sp
      this.blknd  = settings.blknd
      this.bltime = settings.bltime
      this.maxHp  = settings.hp
      this.item   =  settings.item
      this.gravity = 0
      this.hp = this.maxHp
      this.cnt = 0

    update: () ->
      this.cnt++
      # TODO check collision
      this.pos.add(this.vel)
      this.parent()
  })

  EnemyEasy = EnemyTemplate.extend({
    init: (settings) ->
      settings = settings || {}
      settings.image = 'enemy0'
      settings.spritewidth = settings.spriteheight = 32
      this.parent(settings.x, settings.y,settings)

      this.addAnimation('norm', [3,4,5])
      this.addAnimation('move_left', [0,1,2])
      this.addAnimation('move_right', [6,7,8])
      this.setCurrentAnimation('norm')

    # handle movement
    update: () ->
      # for debug
      if this.cnt > 120+this.wait
        this.cnt = 0

      if this.cnt < 60
        this.vel.y = this.sp
      else if this.cnt > 60+this.wait
        this.vel.y = -this.sp
      else 
        this.vel.y = 0

      this.parent()
  })
  ###
  * sprite generator 
  ###
  EnemyGenerator = Object.extend({

    init: (enemyOrder) ->
      this.visible = true   # though this is actually invisible, need this attr to be update on each frame
      this.cnt = 0
      this.enemies = []
      this.enemyOrder = enemyOrder

    update: () ->
      for order in this.enemyOrder
        if this.cnt == order.cnt
          if order.pattern == 0
            me.game.add(new EnemyEasy(order), 50)
      me.game.sort()
      this.cnt++
      return false

    draw: (context) ->

  })
  return {
    PlayerCharacator: me.ObjectEntity.extend({
      init: (x,y,settings) ->
        settings = settings || {}
        settings.name = 'Player'
        settings.image = 'char'
        settings.spritewidth = settings.spriteheight = 73
        this.parent(x, y, settings)

        # this.setVelocity(5.0, 5.0)  # actually acceleration
        this.gravity = 0    # STG doesn't need
        this.addAnimation('norm', [0, 1, 2, 3])
        this.addAnimation('move_right', [4,5,6,7])
        this.addAnimation('move_left', [8,9,10,11])
        this.setCurrentAnimation('norm')

      update: () ->
        isKey = me.input.isKeyPressed
        sayuFlag = jogeFlag = false
        vx = vy = 0.0
        if isKey('left') 
          vx = -5.0
          sayuFlag = true
          this.setCurrentAnimation('move_left')
        else if isKey('right')
          vx = 5.0
          sayuFlag = true
          this.setCurrentAnimation('move_right')
        else 
          this.setCurrentAnimation('norm')

        if isKey('up')
          vy = -5.0
          jogeFlag = true
        else if isKey('down')
          vy = 5.0
          jogeFlag = true
        if sayuFlag && jogeFlag   # handle diagonal move
          vx /=1.4142 
          vy /=1.4142
        if isKey('slow')
          vx /= 2
          vy /= 2
        # if this.x>10 && this.x < global.FIELD_MAX_X && this.y>5 && this.y < global.FIELD_MAX_Y
        this.vel.x = vx
        this.vel.y = vy

        checkMapCollision.call(this)
        this.pos.add(this.vel)
        this.parent()   # update animation
        return true     # return false will pause animation and draw
    })
    EnemyEasy: EnemyEasy
    EnemyGenerator: EnemyGenerator
  }
)