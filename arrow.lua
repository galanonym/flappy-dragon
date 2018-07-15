return function(console)
  -- constants

  -- variables
  local arrowImage
  local arrowX = 1000 -- pixels -- Starting position
  local arrowY = math.random(0, 400) -- pixels
  local arrowSpeedX = 300 -- pixels per second
  local arrowWidthScaled

  -- dragon physics variables
  local arrowBody
  local arrowShape
  local arrowFixture

  local arrow = {}

  arrow.load = function(world)
    arrowImage = love.graphics.newImage('assets/arrow/spritesheet.png')
    arrowWidthScaled = math.ceil(arrowImage:getWidth() * 0.1)

    -- define physics variables
    -- body = love.physics.newBody( world, x, y, type )
    arrowBody = love.physics.newBody(world, arrowX, arrowY, 'dynamic')
    -- shape = love.physics.newRectangleShape( width, height )
    arrowShape = love.physics.newRectangleShape(100, 50)
    -- fixture = love.physics.newFixture( body, shape, density )
    arrowFixture = love.physics.newFixture(arrowBody, arrowShape)
    console.log('arrowWidthScaled', arrowWidthScaled)
  end

  arrow.update = function(dt)
    -- Change postition according to current speed downwards
    arrowX = arrowX - (arrowSpeedX * dt)
    if arrowX < -arrowWidthScaled then
      arrowX = 1000
      arrowY = math.random(0, 400)
      arrowSpeedX = math.random(300, 700)
    end
    -- update arrowX
    arrowBody:setX(arrowX)
    arrowBody:setY(arrowY)
  end

  arrow.draw = function()
    -- love.graphics.setColor( red, green, blue, alpha )
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(arrowImage, arrowX, arrowY, 0, 0.1, 0.1)

    love.graphics.setColor(0.28, 0.63, 0.05)
    love.graphics.polygon("fill", arrowBody:getWorldPoints(arrowShape:getPoints()))
  end

  return arrow
end
