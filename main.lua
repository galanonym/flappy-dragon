-- libraries
local timer = require('lib/hump/timer')
local push = require('lib/push')

-- modules
local paralax = require('paralax')()
local physicsModelFactory = require('physicsModelFactory')
local dragon = require('dragon')(physicsModelFactory)
local bat = require('bat')(physicsModelFactory)
local arrowFactory = require('arrowFactory')(physicsModelFactory)
local enemySpawner = require('enemySpawner')(arrowFactory)

-- variables
local world

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  -- love.window.setMode(1200, 700)
  local windowWidth, windowHeight = love.window.getMode()
  push:setupScreen(1200, 700, windowWidth, windowHeight, {
    resizable = true
  })

  math.randomseed(os.time())

  paralax.load()

  -- love physics variables
  love.physics.setMeter(50)
  world = love.physics.newWorld(0, 9.81*64, true)

  dragon.load(world)
  bat.load(world)
end

function love.update(dt)
  world:update(dt) -- should be first (tutorials use it that way)

  paralax.update(dt)

  dragon.update(dt)
  bat.update(dt)
  enemySpawner.update(dt, world)

  -- Activate timer library
  timer.update(dt)
end

function love.draw()
  push:start()

  -- Set color used for sky
  -- love.graphics.setColor(red, green, blue, alfa)
  love.graphics.setColor(109 / 255, 184 / 255, 226 / 255)

  -- Draw blue sky on screen
  -- love.graphics.rectangle(mode, x, y, width, height)
  love.graphics.rectangle('fill', 0, 0, 1200, 700)

  paralax.draw()

  dragon.draw()
  bat.draw()

  enemySpawner.draw()

  push:finish()
end

function love.keypressed(key)
  if key == 'escape' then
    -- Adds the quit event to the queue.(terminates application)
    love.event.quit()
  end

  -- Push space to fly up with dragon
  if key == 'space' then
    dragon.keypressedSpace()
  end

  -- Push enter to fly up with bat
  if key == 'return' then
    bat.keypressedReturn()
  end
end

function love.resize(w, h)
    push:resize(w, h)
end
