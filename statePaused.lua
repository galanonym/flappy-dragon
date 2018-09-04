-- libraries

-- modules

return function()
  -- constants

  -- variables

  -- main module object
  local statePaused = {}

  statePaused.load = function()
  end -- statePaused.load

  statePaused.update = function(dt)
  end -- statePaused.update

  statePaused.draw = function()
    love.graphics.print('Paused!', 200, 300, 0, 10, 10)
  end -- statePaused.draw

  statePaused.keypressed = function(key)
  end -- statePaused.draw

  return statePaused
end
