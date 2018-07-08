local inspect = require('lib/inspect')
local timer = require('lib/hump/timer')
local console = require('console')(inspect)

-- constants
local ROTATION_DOWNWARD_CHANGE = 1.1 -- radians per second
local ROTATION_MIN_ALLOWED = -0.6 -- radians
local ROTATION_MAX_ALLOWED = 1 -- radians
local GRAVITY = 700 -- acceleration down
local JUMP_SPEED = 500 -- speed change up

local dragonImage
local dragonQuads = {}
local dragonY = 100 -- pixels -- Starting position
local dragonRotation = ROTATION_MIN_ALLOWED -- Initial rotation
local dragonSpeedY = 0 -- pixels per second
local dragonCurrentQuad -- Quad

local dragon = {}
dragon.load = function()
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
end

dragon.update = function(dt)
  -- Increase downwards speed with gravitation
  dragonSpeedY = dragonSpeedY + (GRAVITY * dt)
  -- Change postition according to current speed downwards
  dragonY = dragonY + (dragonSpeedY * dt)

  -- Change rotation when freefalling down, until max rotation reached
  if dragonRotation < ROTATION_MAX_ALLOWED then
    dragonRotation = dragonRotation + (ROTATION_DOWNWARD_CHANGE * dt)
  end

  console.log('dragonY', dragonY)
  console.log('dragonRotation', dragonRotation)

  -- Activate timer library
  timer.update(dt)
end

dragon.draw = function()
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
  love.graphics.draw(dragonImage, dragonCurrentQuad, 100, dragonY, dragonRotation, 0.3, 0.3, 250, 250)

  -- Activate console library
  console.draw()
end

dragon.keypressedSpace = function()
  -- Add "jump" upwards
  dragonSpeedY = -JUMP_SPEED

  -- Do the rotation to initial position with some frames
  -- Angle in radians, between current rotation, and minimal allowed rotation
  local sum = math.abs(dragonRotation) + math.abs(ROTATION_MIN_ALLOWED)
   -- Step is radians to change for each frame.
  local step = sum / 16
  timer.script(function(wait)
    -- Abort when current rotation reaches minimal allowed rotation
    while dragonRotation > ROTATION_MIN_ALLOWED do
      -- Change dragonRotation
      dragonRotation = dragonRotation - step
      -- Make tween effect
      wait(0.001)
    end
  end)

  -- Change quads when flying up with the dragon
  timer.script(function(wait)
    dragonCurrentQuad = dragonQuads[2]
    wait(0.1)
    dragonCurrentQuad = dragonQuads[3]
    wait(0.1)
    dragonCurrentQuad = dragonQuads[4]
    wait(0.05)
    dragonCurrentQuad = dragonQuads[3]
    wait(0.05)
    dragonCurrentQuad = dragonQuads[2]
    wait(0.05)
    dragonCurrentQuad = dragonQuads[1]
  end)
end

return dragon
