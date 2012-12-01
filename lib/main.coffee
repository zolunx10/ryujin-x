define((require, exports) ->
  firstIni = require('ini')
  resources = require('resources')
  entities = require('entities')
  
  jsApp = {
    ### 
      Initialize the jsApp
    ###
    onload: () ->
      me.debug.renderHitBox = true  # turn on render box on spirits for DEBUG

      if !me.video.init('jsapp', 640, 480, false, 1.0)
        alert("Sorry but your browser does not support html 5 canvas.")
        return 
      me.audio.init("mp3,ogg,wav")
      me.loader.onload = this.loaded.bind(this)
      me.loader.preload(resources.resources)
      me.state.change(me.state.LOADING)

    ###
      callback when everything is loaded
    ###
    loaded: () ->
      me.state.set(me.state.PLAY, new PlayScreen())
      me.state.transition("fade","#000000", 250)  # set state.transition to erase the "loading screen" 
      me.state.change(me.state.PLAY)
  }

  PlayScreen = me.ScreenObject.extend({
    onResetEvent: () ->
      # me.levelDirector.loadLevel("stage_blank")
      firstIni()  # must after loadLevel() so that global.ch (.collisionMap) can work

      # draw background
      background = new me.ColorLayer('back', "#000000", 1)
      me.game.add(background)
      # draw background boards
      global.board = [
        new me.SpriteObject(0, 0, me.loader.getImage('board10') , 416, 16), 
        new me.SpriteObject(0, global.FIELD_Y, me.loader.getImage('board11') ),
        new me.SpriteObject(0, global.FIELD_MAX_Y, me.loader.getImage('board12') ),
        new me.SpriteObject(global.FIELD_MAX_X, 0, me.loader.getImage('board20') )
      ]
      for board in global.board
        me.game.add(board, 200)
      # init player 
      global.ch = new entities.PlayerCharacator(global.FIELD_MAX_X/2, global.FIELD_MAX_Y*3/4, {})
      me.game.add(global.ch, 100)
      # init enemies
      enemyGenerator = new entities.EnemyGenerator(resources.story[0])
      me.game.add(enemyGenerator, 10)

      me.game.sort()
      return 

    onDestroyEvent: () ->
  })

  window.onReady(() ->
    jsApp.onload()
  )
)
