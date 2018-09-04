return function()
  -- constants

  -- variables
  love.g.scoreCount = 0

  -- main module object
  local score = {}

  -- LOVE functions
  score.draw = function()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('score: ' .. love.g.scoreCount, 950, 10, 0, 3, 3)
  end -- draw

  -- public functions
  score.increment = function()
    love.g.scoreCount = love.g.scoreCount + 1
  end

  return score
end -- closure
