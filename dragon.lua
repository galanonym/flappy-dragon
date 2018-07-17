local dragonPhysics = require('physicsModelFactory')()

return function(console, timer)
  -- constants
  local ROTATION_DOWNWARD_CHANGE = 1.1 -- radians per second
  local ROTATION_MIN_ALLOWED = -0.6 -- radians
  local ROTATION_MAX_ALLOWED = 1 -- radians
  local GRAVITY = 700 -- acceleration down
  local JUMP_SPEED = 500 -- speed change up

  -- variables
  local dragonImage
  local dragonImageWidth = 500
  local dragonImageHeight = 500
  local dragonQuads = {}
  local dragonX = 100 -- pixels -- Starting position -- stays always the same
  local dragonY = 100 -- pixels -- Starting position
  local dragonRotation = ROTATION_MIN_ALLOWED -- Initial rotation
  local dragonSpeedY = 0 -- pixels per second
  local dragonCurrentQuad -- Quad
  local dragonScale = 0.3

  local dragonPolygons = {}
  dragonPolygons[1] = {
    -- head
    480.00, 364.00,
    359.00, 314.00,
    397.00, 287.00,
    483.00, 333.00,
  }
  dragonPolygons[2] = {
    -- stomac
    359.00,311.00,
    417.00,341.00,
    305.00,393.00,
    57.00,333.00,
    119.00,308.00,
    201.00,304.00,
  }
  dragonPolygons[3] = {
    -- tail
    193.00,300.00,
    160.00,306.00,
    33.00,198.00,
    143.00,230.00,
  }

  -- main module object
  local dragon = {}

  dragon.load = function(world)
    -- Load image from file
    -- love.graphics.newImage(filename) -> Image
    dragonImage = love.graphics.newImage('assets/dragon/spritesheet.png')

    -- Define quad for dragonImage
    -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
    dragonQuads[1] = love.graphics.newQuad(0, 0, dragonImageWidth, dragonImageHeight, dragonImage:getDimensions())
    dragonQuads[2] = love.graphics.newQuad(500, 0, dragonImageWidth, dragonImageHeight, dragonImage:getDimensions())
    dragonQuads[3] = love.graphics.newQuad(1000, 0, dragonImageWidth, dragonImageHeight, dragonImage:getDimensions())
    dragonQuads[4] = love.graphics.newQuad(1500, 0, dragonImageWidth, dragonImageHeight, dragonImage:getDimensions())

    -- initial quad
    dragonCurrentQuad = dragonQuads[1]

    dragonPhysics.load(
      dragonPolygons,
      world,
      dragonX,
      dragonY,
      dragonImageWidth,
      dragonImageHeight,
      dragonScale
    )
  end -- dragon.load

  dragon.update = function(dt)
    -- -- @todo Prevent from flying up above screen
    -- if dragonY < -30 then
    --   dragonPhysics.getBody():setLinearVelocity(0, 0)
    -- end

    -- Fixed x position of the dragon
    dragonPhysics.getBody():setX(dragonX)

    -- Update according to physics model
    dragonY = dragonPhysics.getBody():getY()

    -- Change rotation when freefalling down, until max rotation reached
    if dragonRotation < ROTATION_MAX_ALLOWED then
      dragonRotation = dragonRotation + (ROTATION_DOWNWARD_CHANGE * dt)
      dragonPhysics.getBody():setAngle(dragonRotation)
    end

    console.log('dragonY', dragonY)
    console.log('dragonRotation', dragonRotation)
  end -- dragon.update

  dragon.draw = function()
    -- Set color used for drawing
    -- love.graphics.setColor(red, green, blue, alfa)
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(
      dragonImage,
      dragonCurrentQuad,
      dragonX,
      dragonY,
      dragonRotation,
      dragonScale,
      dragonScale,
      250,
      250
    )

    dragonPhysics.draw()

    -- Activate console library
    -- @todo check this shit
    console.draw()
  end --dragon.draw

  dragon.keypressedSpace = function()
    -- Add "jump" upwards
    dragonSpeedY = -JUMP_SPEED

    -- Add "jump" upwards to physics body
    -- body.applyForce(fx, fy)
    dragonPhysics.getBody():setLinearVelocity(0, 0)
    dragonPhysics.getBody():applyLinearImpulse(0, -500)

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
end
