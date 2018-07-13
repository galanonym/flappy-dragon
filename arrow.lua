return function(console)
  -- constants

  -- variables
  local arrowImage
  local arrowX = 1000 -- pixels -- Starting position
  local arrowY = math.random(0, 400) -- pixels
  local arrowSpeedX = 300 -- pixels per second

  local arrow = {}

  arrow.load = function()
    arrowImage = love.graphics.newImage('assets/arrow/spritesheet.png')
  end

  arrow.update = function(dt)
    -- Change postition according to current speed downwards
    arrowX = arrowX - (arrowSpeedX * dt)
  end

  arrow.draw = function()
    -- love.graphics.setColor( red, green, blue, alpha )
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(arrowImage, arrowX, arrowY, 0, 0.1, 0.1)
  end

  return arrow
end
