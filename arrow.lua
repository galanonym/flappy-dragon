-- modules
local arrowPhysics = require('physicsModelFactory')()

return function(console)
  -- constants

  -- variables
  local arrowImage
  local arrowImageWidth = 500
  local arrowImageHeight = 500
  local arrowX = 1000 -- pixels -- Starting position -- stays always the same
  local arrowY = math.random(0, 400) -- pixels -- Starting position
  local arrowRotation = 0
  local arrowScale = 0.1
  local arrowIsShot = false


  local arrowPolygons = {}
  arrowPolygons[1] = {
    -- head
    359.00,311.00,
    417.00,341.00,
    305.00,393.00,
    57.00,333.00,
    119.00,308.00,
    201.00,304.00,
  }

  -- main module object
  local arrow = {}

  -- LOVE functions
  arrow.load = function(world)
    -- Load image from file
    -- love.graphics.newImage(filename) -> Image
    arrowImage = love.graphics.newImage('assets/arrow/spritesheet.png')

    arrowPhysics.load(
      arrowPolygons,
      world,
      arrowX,
      arrowY,
      arrowImageWidth,
      arrowImageHeight,
      arrowScale
    )
  end -- load

  arrow.update = function()
    -- Update according to physics model
    arrowY = arrowPhysics.getBody():getY()
    -- Update according to physics model
    arrowX = arrowPhysics.getBody():getX()

    -- Initial arrow shot
    if arrowIsShot == false then
      -- Body:applyLinearImpulse( ix, iy )
      arrowPhysics.getBody():applyLinearImpulse(-50, 0)
      arrowIsShot = true
    end

    console.log('arrowY', arrowY)
  end -- update

  arrow.draw = function()
    -- Set color used for drawing
    -- love.graphics.setColor(red, green, blue, alfa)
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(
      arrowImage,
      arrowX,
      arrowY,
      arrowRotation,
      arrowScale,
      arrowScale,
      250,
      250
    )

    arrowPhysics.draw()

    -- Activate console library
    -- @todo check this shit
    console.draw()
  end -- draw

  return arrow
end -- closure
