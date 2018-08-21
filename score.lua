return function()
  -- constants

  -- variables
  local scoreCount = 0

  -- main module object
  local score = {}

  -- LOVE functions
  score.draw = function()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(scoreCount, 10, 10, 0, 3, 3)
  end -- draw

  -- public functions
  score.increment = function()
    scoreCount = scoreCount + 1
  end

  return score
end -- closure
