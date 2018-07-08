-- libraries
-- local inspect = require('lib/inspect')
-- local console = require('console')(inspect)

-- modules
local dragon = require('dragon')
local bat = require('bat')

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
end

function love.draw()
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
