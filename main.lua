local inspect = require('lib/inspect')
local console = require('console')(inspect)

local dragonImage
local dragonQuads = {}

function love.load()
  -- Enter fullscreen mode
  -- love.window.setFullscreen(bool)
  love.window.setFullscreen(true)

  -- Load image from file
  -- love.graphics.newImage(filename) -> Image
  dragonImage = love.graphics.newImage('assets/dragon/spritesheet.png')

  console.log('dragonImage', dragonImage)
  console.log('love.graphics.newImage', love.graphics.newImage)

  -- Define quad for dragonImage
  -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
  dragonQuads[1] = love.graphics.newQuad(0, 0, 500, 500, dragonImage:getDimensions())
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
  -- love.graphics.draw(drawable, x, y, rotation, scaleFactorX, scaleFactorY)
  love.graphics.draw(dragonImage, dragonQuads[1], 0, 0, 0, 0.3, 0.3)

  console.draw()
end
