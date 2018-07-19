return function()
  -- constants

  -- variables
  local cloudImage
  local cloudImageX
  local cloudLoopPoint

  -- main module object
  local paralax = {}

  -- LOVE functions
  paralax.load = function()
    -- backgrounds
    cloudImage = love.graphics.newImage('assets/clouds/spritesheet.png')
    cloudImageX = 0
    cloudLoopPoint = 3840 * 0.3
  end -- load

  paralax.update = function(dt)
    cloudImageX = (cloudImageX + 600 * dt)
    if cloudImageX > cloudLoopPoint then
      cloudImageX = 3
    end

  end -- update

  paralax.draw = function()
    -- Set background color
    love.graphics.setColor(1, 1, 1)

    -- draw the background at the negative looping point
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(cloudImage, -cloudImageX, 0, 0, 0.3, 0.3)
  end -- draw

  return paralax
end -- closure
