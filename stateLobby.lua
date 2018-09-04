-- libraries

-- modules
local paralax = require('paralax')()

return function()
  -- constants

  -- variables
  local batImage
  local batQuad
  local dragonImage
  local dragonQuad
  -- main module object
  local stateLobby = {}

  stateLobby.load = function()
    paralax.load()
    batImage = love.graphics.newImage('assets/bat/spritesheet.png')
    batQuad = love.graphics.newQuad(0, 0, 500, 500, batImage:getDimensions())

    dragonImage = love.graphics.newImage('assets/dragon/spritesheet.png')
    dragonQuad = love.graphics.newQuad(0, 0, 500, 500, dragonImage:getDimensions())
  end -- stateLobby.load

  stateLobby.update = function(dt)
  end -- stateLobby.update

  stateLobby.draw = function()
    love.graphics.setColor(109 / 255, 184 / 255, 226 / 255)
    love.graphics.rectangle('fill', 0, 0, 1200, 700)
    paralax.draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('Flappy Dragon', 350, 50, 0, 6, 6)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(batImage, batQuad, 100, 350, -0.6, 0.4, 0.4, 250, 250)
    love.graphics.draw(dragonImage, dragonQuad, 1000, 300, -0.6, 0.6, 0.6, 250, 250)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print('Press SPACE to jump', 900, 450, 0, 2, 2)
    love.graphics.print('Press ENTER to jump', 25, 450, 0, 2, 2)
  end -- stateLobby.draw

  stateLobby.keypressed = function(key)
    if key == 'space' or key == 'return' then
      love.g.stateCurrent = 'stateGame'
    end
  end -- stateLobby.draw

  return stateLobby
end
