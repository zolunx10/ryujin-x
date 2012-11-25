define((require, exports) ->
  firstIni = require('ini')
  resources = require('resources').resources
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
      me.loader.preload(resources)
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

      # draw background boards
      this.board = [
        new me.SpriteObject(0, 0, me.loader.getImage('board10') , 416, 16), 
        new me.SpriteObject(0, 16, me.loader.getImage('board11') ),
        new me.SpriteObject(0, 464, me.loader.getImage('board12') ),
        new me.SpriteObject(416, 0, me.loader.getImage('board20') )
      ]
      for board in this.board
        me.game.add(board, 1)
      # draw player 
      me.game.add(global.ch, 10)

      me.game.sort()
      return 

    onDestroyEvent: () ->
  })

  window.onReady(() ->
    jsApp.onload()
  )
)
