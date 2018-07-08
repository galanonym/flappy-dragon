local dragonImage
local dragonQuads = {}
local dragonY = 100 -- pixels -- Starting position
local dragonRotation = ROTATION_MIN_ALLOWED -- Initial rotation
local dragonSpeedY = 0 -- pixels per second
local dragonCurrentQuad -- Quad

local dragon = {
  load = function()
    -- Load image from file
    -- love.graphics.newImage(filename) -> Image
    dragonImage = love.graphics.newImage('assets/dragon/spritesheet.png')

    -- Define quad for dragonImage
    -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
    dragonQuads[1] = love.graphics.newQuad(0, 0, 500, 500, dragonImage:getDimensions())
    dragonQuads[2] = love.graphics.newQuad(500, 0, 500, 500, dragonImage:getDimensions())
    dragonQuads[3] = love.graphics.newQuad(1000, 0, 500, 500, dragonImage:getDimensions())
    dragonQuads[4] = love.graphics.newQuad(1500, 0, 500, 500, dragonImage:getDimensions())

    -- initial quad
    dragonCurrentQuad = dragonQuads[1]
  end,
}
