-- libraries
local inspect = require('lib/inspect')
local console = require('console')(inspect)
local timer = require('lib/hump/timer')

-- constants
local ROTATION = 1 -- radians per second
local ROTATION_MIN = -0.6
local ROTATION_MAX = 1
local GRAVITY = 700
local JUMP_SPEED = 400

-- variables
local dragonImage
local dragonQuads = {}
local dragonY = 100
local dragonRotation = 0
local dragonSpeedY = 0 -- pixels per second
local dragonCurrentQuad

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
  dragonQuads[2] = love.graphics.newQuad(500, 0, 500, 500, dragonImage:getDimensions())
  dragonQuads[3] = love.graphics.newQuad(1000, 0, 500, 500, dragonImage:getDimensions())
  dragonQuads[4] = love.graphics.newQuad(1500, 0, 500, 500, dragonImage:getDimensions())

  dragonCurrentQuad = dragonQuads[1]
end

function love.update(dt)
  dragonSpeedY = dragonSpeedY + (GRAVITY * dt)
  dragonY = dragonY + (dragonSpeedY * dt)

  if dragonRotation < ROTATION_MAX then
    dragonRotation = dragonRotation + (ROTATION * dt)
  end

  console.log('dragonY', dragonY)
  console.log('dragonRotation', dragonRotation)

  timer.update(dt)
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
  love.graphics.draw(dragonImage, dragonCurrentQuad, 100, dragonY, dragonRotation, 0.3, 0.3, 250, 250)

  console.draw()
end

function love.keypressed(key)
  if key == 'escape' then
    -- Adds the quit event to the queue.(terminates application)
    love.event.quit()
  end

  if key == 'space' then
    dragonSpeedY = -JUMP_SPEED

    local d = math.abs(dragonRotation)
    local m = math.abs(ROTATION_MIN)
    local sum = d + m
    local step = sum / 4
    console.log('step', step)
    timer.script(function(wait)
      if dragonRotation > ROTATION_MIN then
        dragonRotation = dragonRotation - step
      end
      wait(0.02)
      if dragonRotation > ROTATION_MIN then
        dragonRotation = dragonRotation - step
      end
      wait(0.02)
      if dragonRotation > ROTATION_MIN then
        dragonRotation = dragonRotation - step
      end
      wait(0.02)
      if dragonRotation > ROTATION_MIN then
        dragonRotation = dragonRotation - step
      end
    end)

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
end
