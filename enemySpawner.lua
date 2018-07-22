return function(console)
  -- constants

  -- variables
  local timeToShoot = math.random(10, 50)
  -- main module object
  local enemySpawner = {}

  -- LOVE functions
  enemySpawner.update = function(dt)
    console.log('timeToShoot', timeToShoot)
   while timeToShoot > 0 do
     timeToShoot = timeToShoot - dt
   end
   if timeToShoot < 0 then
     print('shooting arrow')
     timeToShoot = math.random(10, 50)
   end
  end -- update

  return enemySpawner
end -- closure
