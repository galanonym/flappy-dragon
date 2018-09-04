-- libraries
local timer = require('lib/hump/timer')
-- local inspect = require('lib/inspect')

-- modules
local paralax = require('paralax')()
local physicsModelFactory = require('physicsModelFactory')
local dragon = require('dragon')(physicsModelFactory)
local bat = require('bat')(physicsModelFactory)
local arrowFactory = require('arrowFactory')(physicsModelFactory)
local contactFunction = require('contactFunction')
local score = require('score')()
local enemySpawner = require('enemySpawner')(arrowFactory, score)

return function()
  -- constants

  -- variables
  local world

  -- main module object
  local stateGame = {}

  stateGame.load = function()
    paralax.load()

    -- love physics variables
    love.physics.setMeter(50)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(contactFunction)

    dragon.load(world)
    bat.load(world)
  end -- stateGame.load

  stateGame.update = function(dt)
    if bat.batIsDead and dragon.dragonIsDead then
      love.g.stateCurrent = 'stateGameOver'
      dragon.reset()
      bat.reset()
      enemySpawner.reset()
    end

    world:update(dt) -- should be first (tutorials use it that way)

    paralax.update(dt)

    dragon.update(dt)
    bat.update(dt)
    enemySpawner.update(dt, world)


    -- Activate timer library
    timer.update(dt)
  end -- stateGame.update

  stateGame.draw = function()
    -- Set color used for sky
    -- love.graphics.setColor(red, green, blue, alfa)
    love.graphics.setColor(109 / 255, 184 / 255, 226 / 255)

    -- Draw blue sky on screen
    -- love.graphics.rectangle(mode, x, y, width, height)
    love.graphics.rectangle('fill', 0, 0, 1200, 700)

    paralax.draw()

    dragon.draw()
    bat.draw()

    enemySpawner.draw()

    score.draw()
  end -- stateGame.draw

  stateGame.keypressed = function(key)
    if key == 'escape' then
      -- Adds the quit event to the queue.(terminates application)
      love.event.quit()
    end

    -- Push space to fly up with dragon
    if key == 'space' then
      dragon.keypressedSpace()
    end

    -- Push enter to fly up with bat
    if key == 'return' then
      bat.keypressedReturn()
    end

    if key == 'p' then
      love.g.stateCurrent = 'statePaused'
    end
  end -- stateGame.draw

  return stateGame
end
