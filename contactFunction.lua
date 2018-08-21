local timer = require('lib/hump/timer')

return function(fixtureA, fixtureB, constactObject)
  local nameA = fixtureA:getUserData()
  local nameB = fixtureB:getUserData()

  if (string.sub(nameA, 1, 6) == 'dragon' and nameB == 'arrow head') then

    local dragonBody = fixtureA:getBody()
    local arrowBody = fixtureB:getBody()

    local x, y = constactObject:getPositions()

    -- print ('arrow head hit dragon', x, y, inspect(dragonBody), inspect(arrowBody))
    -- Will throw error because World:isLocked() returns true, we wait for next frame
    timer.script(function(wait)
      wait(0.01)
      love.physics.newWeldJoint(dragonBody, arrowBody, x, y)
    end)
  end

  if (string.sub(nameA, 1, 3) == 'bat' and nameB == 'arrow head') then
    local batBody = fixtureA:getBody()
    local arrowBody = fixtureB:getBody()

    local x, y = constactObject:getPositions()

    -- print ('arrow head hit dragon', x, y, inspect(batBody), inspect(arrowBody))
    -- Will throw error because World:isLocked() returns true, we wait for next frame
    timer.script(function(wait)
      wait(0.01)
      love.physics.newWeldJoint(batBody, arrowBody, x, y)
    end)
  end
end
