return function()
  -- constants

  -- variables
  local farCloudImage
  local farCloudX = 0
  local farCloudY = 0
  local farCloudScale = 0.2
  local farCloudSpeed = 10
  local farCloudLoopPoint = 3840 * farCloudScale

  local cloudImage
  local cloudX = 0
  local cloudY = 50
  local cloudScale = 0.4
  local cloudSpeed = 20
  local cloudLoopPoint = 3840 * cloudScale

  local mountineImage
  local mountineX = 0
  local mountineY = 290
  local mountineScale = 0.8
  local mountineSpeed = 40
  local mountineLoopPoint = 3840 * mountineScale

  local treeImage
  local treeX = 0
  local treeY = 350
  local treeScale = 0.6
  local treeSpeed = 80
  local treeLoopPoint = 3840 * treeScale
  -- main module object
  local paralax = {}

  -- LOVE functions
  paralax.load = function()
    cloudImage = love.graphics.newImage('assets/clouds/spritesheet.png')
    farCloudImage = love.graphics.newImage('assets/clouds/spritesheet.png')
    mountineImage = love.graphics.newImage('assets/mounitnes/spritesheet.png')
    treeImage = love.graphics.newImage('assets/trees/spritesheet.png')
  end -- load

  paralax.update = function(dt)
    cloudX = (cloudX + cloudSpeed * dt)
    if cloudX > cloudLoopPoint then
      cloudX = 3
    end

    farCloudX = (farCloudX + farCloudSpeed * dt)
    if farCloudX > farCloudLoopPoint then
      farCloudX = 3
    end

    mountineX = (mountineX + mountineSpeed * dt)
    if mountineX > mountineLoopPoint then
      mountineX = 3
    end

    treeX = (treeX + treeSpeed * dt)
    if treeX > treeLoopPoint then
      treeX = 3
    end
  end -- update

  paralax.draw = function()
    -- Set background color
    love.graphics.setColor(1, 1, 1)

    -- draw the background at the negative looping point
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(cloudImage, -cloudX, cloudY, 0, cloudScale, cloudScale)
    love.graphics.draw(farCloudImage, -farCloudX, farCloudY, 0, farCloudScale, farCloudScale)
    love.graphics.draw(mountineImage, -mountineX, mountineY, 0, mountineScale, mountineScale)
    love.graphics.draw(treeImage, -treeX, treeY, 0, treeScale, treeScale)
  end -- draw

  return paralax
end -- closure
