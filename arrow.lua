-- modules
local arrowPhysics = require('physicsModelFactory')()

return function(console)
  -- constants

  -- variables
  -- @todo check where is it in code
  -- local arrowSpeedX = 700 -- pixels per second

  local arrowImage
  local arrowImageWidth = 500
  local arrowImageHeight = 500
  local arrowX = 1000 -- pixels -- Starting position -- stays always the same
  local arrowY = math.random(0, 400) -- pixels -- Starting position
  local arrowRotation = 0
  local arrowScale = 0.1


    local arrowPolygons = {}
    arrowPolygons[1] = {
      -- head
      193.00,300.00,
      160.00,306.00,
      33.00,198.00,
      143.00,230.00,
    }
    -- arrowPolygons[2] = {
    --   -- stomac
    -- }
    -- arrowPolygons[3] = {
    --   -- tail
    -- }

  -- main module object
  local arrow = {}

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
    -- Fixed x position of the dragon
    -- dragonPhysics.getBody():setX(dragonX)

    -- Update according to physics model
    arrowY = arrowPhysics.getBody():getY()
    --     -- Change postition according to current speed downwards
    --     arrowX = arrowX - (arrowSpeedX * dt)
    --     if arrowX < -arrowWidthScaled then
    --       arrowX = 1000
    --       arrowY = math.random(0, 400)
    --       arrowSpeedX = math.random(300, 700)
    --     end
    --     -- update arrowX
    --     arrowBody:setX(arrowX)
    --     arrowBody:setY(arrowY)
    --   end

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
end

--   -- dragon physics variables
--   local arrowBody
--   local arrowShape
--   local arrowFixture
--
--   local arrow = {}
--
--   arrow.load = function(world)
--     arrowImage = love.graphics.newImage('assets/arrow/spritesheet.png')
--     arrowWidthScaled = math.ceil(arrowImage:getWidth() * 0.1)
--
--     -- define physics variables
--     -- body = love.physics.newBody( world, x, y, type )
--     arrowBody = love.physics.newBody(world, arrowX, arrowY, 'dynamic')
--     -- shape = love.physics.newRectangleShape( width, height )
--     arrowShape = love.physics.newRectangleShape(100, 50)
--     -- fixture = love.physics.newFixture( body, shape, density )
--     arrowFixture = love.physics.newFixture(arrowBody, arrowShape)
--     console.log('arrowWidthScaled', arrowWidthScaled)
--   end
--
--   arrow.update = function(dt)
--     -- Change postition according to current speed downwards
--     arrowX = arrowX - (arrowSpeedX * dt)
--     if arrowX < -arrowWidthScaled then
--       arrowX = 1000
--       arrowY = math.random(0, 400)
--       arrowSpeedX = math.random(300, 700)
--     end
--     -- update arrowX
--     arrowBody:setX(arrowX)
--     arrowBody:setY(arrowY)
--   end
--
--   arrow.draw = function()
--     -- love.graphics.setColor( red, green, blue, alpha )
--     love.graphics.setColor(1, 1, 1)
--
--     -- Draw a drawable object into the screen
--     -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
--     love.graphics.draw(arrowImage, arrowX, arrowY, 0, 0.1, 0.1)
--
--     love.graphics.setColor(0.28, 0.63, 0.05)
--     love.graphics.polygon("fill", arrowBody:getWorldPoints(arrowShape:getPoints()))
--   end
--
--   return arrow
-- end
