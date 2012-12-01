define({
  resources: [
    {
      name: "board10"
      type: "image"
      src:  "dat/img/board/10.png"
    }
    {
      name: "board11"
      type: "image"
      src:  "dat/img/board/11.png"
    }
    {
      name: "board12"
      type: "image"
      src:  "dat/img/board/12.png"
    }
    {
      name: "board20"
      type: "image"
      src:  "dat/img/board/20.png"
    }
    {
      name: "char"
      type: "image"
      src:  "dat/img/char/0.png"
    }
    {
      name: "enemy0"
      type: "image"
      src: "dat/img/enemy/0.png"
    }
    # {
    #   name: "stage_blank"
    #   type: "tmx"
    #   src: "dat/blank.tmx"
    # }
  ],
  story: [
    JSON.parse('[{"pattern":0,"cnt":80,"wait":120,"x":140,"y":-20,"sp":2,"blknd":[],"bltime":[],"color":0,"hp":100,"item":[]},{"pattern":0,"cnt":90,"wait":120,"x":170,"y":-20,"sp":2,"blknd":[],"bltime":[],"color":0,"hp":100,"item":[]},{"pattern":0,"cnt":100,"wait":120,"x":200,"y":-20,"sp":2,"blknd":[],"bltime":[],"color":0,"hp":100,"item":[]},{"pattern":0,"cnt":110,"wait":120,"x":230,"y":-20,"sp":2,"blknd":[],"bltime":[],"color":0,"hp":100,"item":[]}]'),
  ]
})