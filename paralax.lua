return function()
  -- constants

  -- variables
  local cloudImage
  local cloudX = 0
  local cloudScale = 0.3
  local cloudSpeed = 30
  local cloudLoopPoint = 3840 * cloudScale

  -- main module object
  local paralax = {}

  -- LOVE functions
  paralax.load = function()
    cloudImage = love.graphics.newImage('assets/clouds/spritesheet.png')
  end -- load

  paralax.update = function(dt)
    cloudX = (cloudX + cloudSpeed * dt)
    if cloudX > cloudLoopPoint then
      cloudX = 3
    end

  end -- update

  paralax.draw = function()
    -- Set background color
    love.graphics.setColor(1, 1, 1)

    -- draw the background at the negative looping point
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(cloudImage, -cloudX, 0, 0, cloudScale, cloudScale)
  end -- draw

  return paralax
end -- closure
