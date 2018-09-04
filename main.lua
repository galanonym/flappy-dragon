local push = require('lib/push')

local stateGame = require('stateGame')()
local statePaused = require('statePaused')()

love.stateCurrent = 'statePaused'

local stateMap = {}
stateMap.stateGame = stateGame
stateMap.statePaused = statePaused

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  -- love.window.setMode(1200, 700)
  local windowWidth, windowHeight = love.window.getMode()
  push:setupScreen(1200, 700, windowWidth, windowHeight, {
    resizable = true
  })

  math.randomseed(os.time())

  stateGame.load()
  statePaused.load()
end

function love.update(dt)
  stateMap[love.stateCurrent].update(dt)
end

function love.draw()
  push:start()

  stateMap[love.stateCurrent].draw()

  push:finish()
end

function love.keypressed(key)
  stateMap[love.stateCurrent].keypressed(key)
end

function love.resize(w, h)
    push:resize(w, h)
end
