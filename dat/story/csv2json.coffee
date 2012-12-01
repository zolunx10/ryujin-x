#!/usr/bin/env coffee
fs = require('fs')
path = require('path')
os = require('os')

convert = (filename) ->
  fs.readFile(filename, 'utf-8', (err, data) ->
    if err 
      throw err
    lines = data.split(/\r?\n/)
    if !lines
      return -1
    regComma = /\s*,\s*/
    name = lines[0].split(regComma)
    res = []
    for i in [1...lines.length]
      if !lines[i]
        continue
      line = lines[i].split(regComma)
      t = {}
      for j in [0...name.length]
        t[name[j]] = JSON.parse(line[j])
      res.push(t)
    fs.writeFile(path.join(path.dirname(filename), path.basename(filename, ".csv")+".json"), JSON.stringify(res), 'utf-8')
    return res
  )

convert(path.join(__dirname, "storyH0.csv"))