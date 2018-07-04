local inspect = require('lib/inspect')
local console = require('console')(inspect)

local dragonImage
local dragonQuads = {}
local dragonY = 200
local GRAVITY = 200 -- pixels per second

function love.load()
  -- Sets display mode and properties of window
  -- love.window.setMode(width, height, flagsTable)
  love.window.setMode(1200, 700)

  -- Load image from file
  -- love.graphics.newImage(filename) -> Image
  dragonImage = love.graphics.newImage('assets/dragon/spritesheet.png')

  -- Define quad for dragonImage
  -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
  dragonQuads[1] = love.graphics.newQuad(0, 0, 500, 500, dragonImage:getDimensions())
end

function love.update(dt)
  dragonY = dragonY + (GRAVITY * dt)
  console.log('dragonY', dragonY)
end

function love.draw()
  -- Set color used for drawing
  -- love.graphics.setColor(red, green, blue, alfa)
  love.graphics.setColor(0.14, 0.36, 0.46)

  -- Draw rectangle on screen
  -- love.graphics.rectangle(mode, x, y, width, height)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- Set color used for drawing
  -- love.graphics.setColor(red, green, blue, alfa)
  love.graphics.setColor(1, 1, 1)

  -- Draw a drawable object into the screen
  -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY)
  love.graphics.draw(dragonImage, dragonQuads[1], 0, dragonY, 0, 0.3, 0.3)

  console.draw()
end

function love.keypressed(key)
  console.log('key', key)
  if key == 'escape' then
    -- Adds the quit event to the queue.(terminates application)
    love.event.quit()
  end
end
