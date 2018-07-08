-- libraries
local inspect = require('lib/inspect')
local console = require('console')(inspect)

-- modules
local dragon = require('dragon')

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  love.window.setMode(1200, 700)

  dragon.load()
end

function love.update(dt)
  dragon.update(dt)

end

function love.draw()
  dragon.draw()
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
end
