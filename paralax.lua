return function()
  -- constants

  -- variables
  local cloudImage
  local cloudX = 0
  local cloudScale = 0.4
  local cloudSpeed = 20
  local cloudLoopPoint = 3840 * cloudScale

  local mountineImage
  local mountineX = 0
  local mountineY = 350
  local mountineScale = 0.7
  local mountineSpeed = 40
  local mountineLoopPoint = 3840 * mountineScale

  -- main module object
  local paralax = {}

  -- LOVE functions
  paralax.load = function()
    cloudImage = love.graphics.newImage('assets/clouds/spritesheet.png')
    mountineImage = love.graphics.newImage('assets/mounitnes/spritesheet.png')
  end -- load

  paralax.update = function(dt)
    cloudX = (cloudX + cloudSpeed * dt)
    if cloudX > cloudLoopPoint then
      cloudX = 3
    end

    mountineX = (mountineX + mountineSpeed * dt)
    if mountineX > mountineLoopPoint then
      mountineX = 3
    end
  end -- update

  paralax.draw = function()
    -- Set background color
    love.graphics.setColor(1, 1, 1)

    -- draw the background at the negative looping point
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(cloudImage, -cloudX, 0, 0, cloudScale, cloudScale)
    love.graphics.draw(mountineImage, -mountineX, mountineY, 0, mountineScale, mountineScale)
  end -- draw

  return paralax
end -- closure
