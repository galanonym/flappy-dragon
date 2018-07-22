-- modules
local arrowPhysics = require('physicsModelFactory')()

return function(console)
  return function()
    -- variables
    local arrowImage
    local arrowImageWidth = 500
    local arrowImageHeight = 500
    local arrowScale = 0.1

    local arrowPolygons = {}
    arrowPolygons[1] = {
      -- head
      131.00,81.00,
      114.00,53.00,
      11.00,89.00,
      115.00,142.00,
      129.00,117.00,
    }
    arrowPolygons[2] = {
      -- stick
      804.00,83.00,
      128.00,74.00,
      125.00,129.00,
      812.00,119.00,
    }
    arrowPolygons[3] = {
      -- back
      827.00,19.00,
      812.00,77.00,
      813.00,115.00,
      836.00,168.00,
      991.00,169.00,
      992.00,20.00,
    }

    local arrowX = 1000 -- pixels -- Starting position -- stays always the same
    local arrowY = math.random(0, 400) -- pixels -- Starting position
    local arrowRotation = 0
    local arrowIsShot = false


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

    arrow.update = function(dt)
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
end -- closure
