return function(arrowFactory)
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
      timeToShoot = math.random(0.1, 0.3)

      local arrow = arrowFactory()
      arrow.load(world)
      projectiles[#projectiles + 1] = arrow
    end

    for _, projectile in pairs(projectiles) do
      projectile.update(dt)
    end
  end -- update

  enemySpawner.draw = function()
    for _, projectile in pairs(projectiles) do
      projectile.draw()
    end
  end

  return enemySpawner
end -- closure
