return function(arrowFactory, score)
  -- constants

  -- variables
  local timeToShoot = 0.2; -- first arrow
  local projectiles = {}
  local difficultyIncreaseOverTime = 0.7 -- higher number = more difficult
  local difficultySteep = 2.5 -- higher number = more time passes until more difficult
  local timeToShootMin = 0.5
  local timeToShootMax = 2

  -- main module object
  local enemySpawner = {}

  -- LOVE functions
  enemySpawner.update = function(dt, world)
    if timeToShoot > 0 then
      timeToShoot = timeToShoot - dt
    else
      timeToShoot = math.random(timeToShootMin, timeToShootMax)

      timeToShootMin = timeToShootMin - (dt * difficultyIncreaseOverTime * (timeToShootMin ^ difficultySteep))
      if timeToShootMin <= 0 then
        timeToShootMin = 0.1
      end

      timeToShootMax = timeToShootMax - (dt * difficultyIncreaseOverTime * (timeToShootMax ^ difficultySteep))
      if timeToShootMax <= 0 then
        timeToShootMax = 0.1
      end

      print('min', timeToShootMin, 'max', timeToShootMax)

      local arrow = arrowFactory()
      arrow.load(world)
      projectiles[#projectiles + 1] = arrow
    end

    for _, projectile in pairs(projectiles) do
      projectile.update(dt)
    end

    for index, projectile in pairs(projectiles) do
      if projectile.isOffScreen() then
        projectiles[index] = nil
        score.increment()
      end
    end
  end -- update

  enemySpawner.draw = function()
    for _, projectile in pairs(projectiles) do
      projectile.draw()
    end
  end

  return enemySpawner
end -- closure
