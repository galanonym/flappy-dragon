return function(console, timer)
  -- constants
  local ROTATION_DOWNWARD_CHANGE = 1.1 -- radians per second
  local ROTATION_MIN_ALLOWED = -0.6 -- radians
  local ROTATION_MAX_ALLOWED = 1 -- radians
  local GRAVITY = 700 -- acceleration down
  local JUMP_SPEED = 500 -- speed change up

  -- variables
  local batImage
  local batQuads = {}
  local batY = 200 -- pixels -- Starting position
  local batRotation = ROTATION_MIN_ALLOWED -- Initial rotation
  local batSpeedY = 0 -- pixels per second
  local batCurrentQuad -- Quad

  local bat = {}

  bat.load = function()
    -- Load image from file
    -- love.graphics.newImage(filename) -> Image
    batImage = love.graphics.newImage('assets/bat/spritesheet.png')

    -- Define quad for batImage
    -- love.graphics.newQuad(x, y, width, height, sheetWidth, sheetHeight) -> Quad
    batQuads[1] = love.graphics.newQuad(0, 0, 500, 500, batImage:getDimensions())
    batQuads[2] = love.graphics.newQuad(500, 0, 500, 500, batImage:getDimensions())
    batQuads[3] = love.graphics.newQuad(1000, 0, 500, 500, batImage:getDimensions())
    batQuads[4] = love.graphics.newQuad(1500, 0, 500, 500, batImage:getDimensions())

    -- initial quad
    batCurrentQuad = batQuads[1]
  end

  bat.update = function(dt)
    -- Prevent from flying up above screen
    if batY < -15 then
      batSpeedY = 0
    end

    -- Increase downwards speed with gravitation
    batSpeedY = batSpeedY + (GRAVITY * dt)
    -- Change postition according to current speed downwards
    batY = batY + (batSpeedY * dt)

    -- Change rotation when freefalling down, until max rotation reached
    if batRotation < ROTATION_MAX_ALLOWED then
      batRotation = batRotation + (ROTATION_DOWNWARD_CHANGE * dt)
    end

    console.log('batY', batY)
    console.log('batRotation', batRotation)
  end

  bat.draw = function()
    -- Set color used for drawing
    -- love.graphics.setColor(red, green, blue, alfa)
    love.graphics.setColor(1, 1, 1)

    -- Draw a drawable object into the screen
    -- love.graphics.draw(drawable, [quad], x, y, rotation, scaleFactorX, scaleFactorY, originOffsetX, originOffsetY)
    love.graphics.draw(batImage, batCurrentQuad, 250, batY, batRotation, 0.2, 0.2, 250, 250)

    -- Activate console library
    console.draw()
  end

  bat.keypressedReturn = function()
    -- Add "jump" upwards
    if batY > 0 then
      batSpeedY = -JUMP_SPEED
    end

    -- Do the rotation to initial position with some frames
    -- Angle in radians, between current rotation, and minimal allowed rotation
    local sum = math.abs(batRotation) + math.abs(ROTATION_MIN_ALLOWED)
     -- Step is radians to change for each frame.
    local step = sum / 16
    timer.script(function(wait)
      -- Abort when current rotation reaches minimal allowed rotation
      while batRotation > ROTATION_MIN_ALLOWED do
        -- Change batRotation
        batRotation = batRotation - step
        -- Make tween effect
        wait(0.001)
      end
    end)

    -- Change quads when flying up with the bat
    timer.script(function(wait)
      batCurrentQuad = batQuads[2]
      wait(0.15)
      batCurrentQuad = batQuads[3]
      wait(0.15)
      batCurrentQuad = batQuads[4]
      wait(0.08)
      batCurrentQuad = batQuads[3]
      wait(0.08)
      batCurrentQuad = batQuads[2]
      wait(0.08)
      batCurrentQuad = batQuads[1]
    end)
  end

  return bat
end
