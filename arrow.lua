return function(console)
  -- constants

  -- variables
  -- local arrowImage
  local arrowX
  local arrowY = 1000 -- pixels -- Starting position
  local arrowSpeedX = 5 -- pixels per second

  local arrow = {}

  arrow.load = function()
    -- arrowImage = love.graphics.newImage('assets/arrow/spritesheet.png')
  end

  arrow.update = function(dt)
    -- Change postition according to current speed downwards
    arrowY = arrowY - (arrowSpeedX * dt)
  end

  arrow.draw = function()
    -- love.graphics.setColor( red, green, blue, alpha )
    love.graphics.setColor(255, 0, 0, 0)
    -- love.graphics.rectangle( mode, x, y, width, height )
    love.graphics.rectangle( 'fill', arrowX, arrowY, 100, 25 )
  end

  return arrow
end
