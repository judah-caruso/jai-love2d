local game = require "libgame"

function love.load()
   game.load()
end

function love.update(dt)
   if game.update(dt) then
      love.event.quit()
   end
end

function love.draw()
   game.draw()
end
