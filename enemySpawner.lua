return function(console)
  -- constants

  -- variables
  local timeToShoot = 0.2; -- first arrow

  -- main module object
  local enemySpawner = {}

  -- LOVE functions
  enemySpawner.update = function(dt)
    if timeToShoot > 0 then
      timeToShoot = timeToShoot - dt
    else
      timeToShoot = math.random(1, 10)
      print('shooting arrow')
    end
  end -- update

  return enemySpawner
end -- closure
