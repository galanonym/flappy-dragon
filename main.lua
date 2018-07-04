-- libraries
local inspect = require('lib/inspect')
local console = require('console')(inspect)

-- constants
local ROTATION = 1 -- radians per second
local GRAVITY = 700

-- variables
local dragonImage
local dragonQuads = {}
local dragonY = 100
local dragonRotation = 0
local dragonSpeedY = 0 -- pixels per second

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
  dragonSpeedY = dragonSpeedY + (GRAVITY * dt)
  dragonY = dragonY + (dragonSpeedY * dt)

  if dragonRotation < 1 then
    dragonRotation = dragonRotation + (ROTATION * dt)
  end

  console.log('dragonY', dragonY)
  console.log('dragonRotation', dragonRotation)
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
  -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
  love.graphics.draw(dragonImage, dragonQuads[1], 100, dragonY, dragonRotation, 0.3, 0.3, 250, 250)

  console.draw()
end

function love.keypressed(key)
  if key == 'escape' then
    -- Adds the quit event to the queue.(terminates application)
    love.event.quit()
  end

  -- if key == 'space' then
  --   gra
  -- end
end
