-- libraries

-- modules

return function()
  -- constants

  -- variables

  -- main module object
  local statePaused = {}

  -- statePaused.load = function()
  -- end -- statePaused.load

  statePaused.update = function(dt)
  end -- statePaused.update

  statePaused.draw = function()
    love.graphics.print('Game over!', 100, 200, 0, 10, 10)
    love.graphics.print('score: ' .. love.g.scoreCount, 950, 10, 0, 3, 3)
    love.graphics.print('Press R to restart', 100, 350, 0, 5, 5)
  end -- statePaused.draw

  statePaused.keypressed = function(key)
    if key == 'r' then
      love.g.scoreCount = 0
      love.g.stateCurrent = 'stateGame'
    end
  end -- statePaused.draw

  return statePaused
end
