-- local inspect = require('lib/inspect')
local timer = require('lib/hump/timer')

return function(physicsModelFactory)
  -- constants

  -- variables
  local dragonPhysics = physicsModelFactory()
  local dragonImage
  local dragonImageWidth = 500
  local dragonImageHeight = 500
  local dragonQuads = {}
  local dragonX = 100 -- pixels -- Starting position -- stays always the same
  local dragonY = 100 -- pixels -- Starting position
  local dragonRotation = -0.6 -- Initial rotation in radians
  local dragonCurrentQuad -- Quad
  local dragonScale = 0.3

  local dragonPolygons = {}
  dragonPolygons[1] = {
    -- head
    480.00, 364.00,
    483.00, 333.00,
    397.00, 287.00,
    359.00, 314.00,
  }
  dragonPolygons[2] = {
    -- stomac
    359.00,311.00,
    201.00,304.00,
    119.00,308.00,
    57.00,333.00,
    305.00,393.00,
    417.00,341.00,
  }
  dragonPolygons[3] = {
    -- tail
    193.00,300.00,
    143.00,230.00,
    33.00,198.00,
    160.00,306.00,
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

  dragon.update = function()
    if dragonY < 40 then
      dragonPhysics.getBody():applyLinearImpulse(0, 100)
    end

    if dragonY < 0 then
      dragonPhysics.getBody():applyLinearImpulse(0, 100)
    end

    -- Fixed x position of the dragon
    dragonPhysics.getBody():setX(dragonX)

    -- Update sprite according to physics model
    -- We use those variables right under too
    dragonX = dragonPhysics.getBody():getX()
    dragonY = dragonPhysics.getBody():getY()
    dragonRotation = dragonPhysics.getBody():getAngle()

    -- Make rotation value always between 0 and 6.28320
    if (dragonRotation > 6.28319) then
      dragonRotation = 0
      dragonPhysics.getBody():setAngle(0)
    end
    if (dragonRotation < 0) then
      dragonRotation = 6.28320
      dragonPhysics.getBody():setAngle(6.28320)
    end

    -- Check velocity in Y direction
    local _, velocityY = dragonPhysics.getBody():getLinearVelocity()

    -- If moving down
    if (velocityY > 0) then
      -- Check if dragon head is pointing right
      if (dragonRotation > 4.71 and dragonRotation <= 6.28320) or (dragonRotation >= 0 and dragonRotation < 1.22) then
        dragonPhysics.getBody():applyTorque(2000)
      end
      -- Check if dragon head is pointing left
      if dragonRotation > 1.22 and dragonRotation < 4.71 then
        dragonPhysics.getBody():applyTorque(-2000)
      end
    end

    -- If moving up
    if (velocityY < 0) then
      -- Check if dragon head is pointing up
      if (dragonRotation > 3.14 and dragonRotation <= 6.28320) then
        dragonPhysics.getBody():applyTorque(4000)
      end
      -- Check if dragon head is pointing down
      if dragonRotation >= 0 and dragonRotation < 3.14 then
        dragonPhysics.getBody():applyTorque(-4000)
      end
    end -- if
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
  end --dragon.draw

  dragon.keypressedSpace = function()
    -- Add "jump" upwards to physics body
    -- body.applyForce(fx, fy)
    dragonPhysics.getBody():setLinearVelocity(0, 0)
    dragonPhysics.getBody():applyLinearImpulse(0, -500)

    -- @todo Add nice comment
    if (dragonRotation > 3.14 and dragonRotation <= 6.28320) then
      local absoluteRotation = dragonRotation - 3.14
      dragonPhysics.getBody():applyAngularImpulse(1000 * absoluteRotation)
      print('flyup negative torque')
    end
    if dragonRotation >= 0 and dragonRotation < 3.14 then
      dragonPhysics.getBody():applyAngularImpulse(-1000 * dragonRotation)
      print('flyup positive torque')
    end

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
