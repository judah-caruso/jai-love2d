local game = require "libgame"

love.load = game.load
love.draw = game.draw

function love.update(dt)
   if game.update(dt) then love.event.quit() end
end

