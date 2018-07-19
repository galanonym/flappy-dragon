-- libraries
local inspect = require('lib/inspect')
local console = require('console')(inspect)
local timer = require('lib/hump/timer')

-- modules
local dragon = require('dragon')(console, timer)
local bat = require('bat')(console, timer)
local arrow = require('arrow')(console)

local world

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  love.window.setMode(1200, 700)
  math.randomseed(os.time())

  -- backgrounds
  local cloudImage = love.graphics.newImage('clouds/spritesheet.png')
  local cloudImageX = 0
  local cloudLoopPoint = 3840

  -- love physics variables
  love.physics.setMeter(50)
  world = love.physics.newWorld(0, 9.81*64, true)

  dragon.load(world)
  bat.load(world)
  arrow.load(world)
end

function love.update(dt)
  world:update(dt) -- should be first (tutorials use it that way)

  dragon.update(dt)
  bat.update(dt)
  arrow.update(dt)
  -- Activate timer library
  timer.update(dt)
end

function love.draw()
  -- Set color used for sky
  -- love.graphics.setColor(red, green, blue, alfa)
  love.graphics.setColor(0.14, 0.36, 0.46)

  -- Draw blue sky on screen
  -- love.graphics.rectangle(mode, x, y, width, height)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- Set background color
  love.graphics.setColor(1, 1, 1)

  -- draw the background at the negative looping point
  love.graphics.draw(cloudImage, -backgroundScroll, 0)

  dragon.draw()
  bat.draw()
  arrow.draw()
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
