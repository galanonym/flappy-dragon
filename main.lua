-- libraries
local inspect = require('lib/inspect')
local console = require('console')(inspect)
local timer = require('lib/hump/timer')

-- modules
local dragon = require('dragon')(console, timer)
local bat = require('bat')(console, timer)

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  love.window.setMode(1200, 700)

  dragon.load()
  bat.load()
end

function love.update(dt)
  dragon.update(dt)
  bat.update(dt)

  -- Activate timer library
  timer.update(dt)
end

function love.draw()
  -- Set color used for drawing
  -- love.graphics.setColor(red, green, blue, alfa)
  love.graphics.setColor(0.14, 0.36, 0.46)

  -- Draw rectangle on screen
  -- love.graphics.rectangle(mode, x, y, width, height)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  dragon.draw()
  bat.draw()
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
