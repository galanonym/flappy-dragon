local inspect = require('lib/inspect')
local console = require('console')(inspect)

-- modules
local arrowFactory = require('arrow')(console)

return function(console)
  -- constants

  -- variables
  local timeToShoot = 0.2; -- first arrow
  local projectiles = {}

  -- main module object
  local enemySpawner = {}

  -- LOVE functions
  enemySpawner.update = function(dt, world)
    if timeToShoot > 0 then
      timeToShoot = timeToShoot - dt
    else
      timeToShoot = math.random(1, 10)

      print('shooting arrow')
      local arrow = arrowFactory()
      arrow.load(world)
      projectiles[#projectiles + 1] = arrow
    end

    for _, projectile in pairs(projectiles) do
      projectile.update(dt)
    end
  end -- update

  return enemySpawner
end -- closure
