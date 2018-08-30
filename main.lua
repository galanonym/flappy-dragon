local push = require('lib/push')

local stateGame = require('stateGame')()

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
end

function love.update(dt)
  stateGame.update(dt)
end

function love.draw()
  push:start()

  stateGame.draw()

  push:finish()
end

function love.keypressed(key)
  stateGame.keypressed(key)
end

function love.resize(w, h)
    push:resize(w, h)
end
