-- modules
local batPhysics = require('physicsModelFactory')()

return function(console, timer)
  -- constants
  local ROTATION_DOWNWARD_CHANGE = 1.1 -- radians per second
  local ROTATION_MIN_ALLOWED = -0.6 -- radians
  local ROTATION_MAX_ALLOWED = 1 -- radians

  -- variables
  local batImage
  local batImageWidth = 500
  local batImageHeight = 500
  local batQuads = {}
  local batY = 200 -- pixels -- Starting position
  local batX = 250
  local batRotation = ROTATION_MIN_ALLOWED -- Initial rotation
  local batCurrentQuad -- Quad
  local batScale = 0.2

  local batPolygons = {}
  batPolygons[1] = {
    -- head
    366.00,237.00,
    356.00,302.00,
    380.00,354.00,
    420.00,370.00,
    439.00,337.00,
    418.00,296.00,
  }
  batPolygons[2] = {
    -- stomac
    378.00,351.00,
    352.00,307.00,
    254.00,275.00,
    53.00,282.00,
    29.00,310.00,
    287.00,396.00,
  }

  local bat = {}

  bat.load = function(world)
    -- Load image from file
    -- love.graphics.newImage(filename) -> Image
    batImage = love.graphics.newImage('assets/bat/spritesheet.png')

    -- Define quad for batImage
    -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
    batQuads[1] = love.graphics.newQuad(0, 0, batImageWidth, batImageHeight, batImage:getDimensions())
    batQuads[2] = love.graphics.newQuad(500, 0, batImageWidth, batImageHeight, batImage:getDimensions())
    batQuads[3] = love.graphics.newQuad(1000, 0, batImageWidth, batImageHeight, batImage:getDimensions())
    batQuads[4] = love.graphics.newQuad(1500, 0, batImageWidth, batImageHeight, batImage:getDimensions())

    -- initial quad
    batCurrentQuad = batQuads[1]


    batPhysics.load(
      batPolygons,
      world,
      batX,
      batY,
      batImageWidth,
      batImageHeight,
      batScale
    )
  end

  bat.update = function(dt)
    -- Prevent from flying up above screen
    -- if batY < -15 then
    --   batSpeedY = 0
    -- end

    -- Fixed x position of the bat
    batPhysics.getBody():setX(batX)
    -- Update according to physics model
    batY = batPhysics.getBody():getY()

    -- Change rotation when freefalling down, until max rotation reached
    if batRotation < ROTATION_MAX_ALLOWED then
      batRotation = batRotation + (ROTATION_DOWNWARD_CHANGE * dt)
      batPhysics.getBody():setAngle(batRotation)
    end

    console.log('batY', batY)
    console.log('batRotation', batRotation)
  end

  bat.draw = function()
    -- Set color used for drawing
    -- love.graphics.setColor(red, green, blue, alfa)
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(
      batImage,
      batCurrentQuad,
      batX,
      batY,
      batRotation,
      batScale,
      batScale,
      250,
      250
    )

    batPhysics.draw()

    -- Activate console library
    console.draw()
  end

  bat.keypressedReturn = function()
    -- Add "jump" upwards to physics body
    -- body.applyForce(fx, fy)
    batPhysics.getBody():setLinearVelocity(0, 0)
    batPhysics.getBody():applyLinearImpulse(0, -200)

    -- Do the rotation to initial position with some frames
    -- Angle in radians, between current rotation, and minimal allowed rotation
    local sum = math.abs(batRotation) + math.abs(ROTATION_MIN_ALLOWED)
     -- Step is radians to change for each frame.
    local step = sum / 16
    timer.script(function(wait)
      -- Abort when current rotation reaches minimal allowed rotation
      while batRotation > ROTATION_MIN_ALLOWED do
        -- Change batRotation
        batRotation = batRotation - step
        -- Make tween effect
        wait(0.001)
      end
    end)

    -- Change quads when flying up with the bat
    timer.script(function(wait)
      batCurrentQuad = batQuads[2]
      wait(0.15)
      batCurrentQuad = batQuads[3]
      wait(0.15)
      batCurrentQuad = batQuads[4]
      wait(0.08)
      batCurrentQuad = batQuads[3]
      wait(0.08)
      batCurrentQuad = batQuads[2]
      wait(0.08)
      batCurrentQuad = batQuads[1]
    end)
  end

  return bat
end
