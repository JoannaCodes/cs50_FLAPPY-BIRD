--With Background and Ground

push = require 'push'

--===========================================================================================================

WIDTH = 1280
HEIGHT = 700

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--===========================================================================================================
--Background >> local function prevents the variables to be accesible globally
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

--LOAD=======================================================================================================
function love.load()
    --Virtual Filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --Window Title
    love.window.setTitle('Flappy Bird')

    --Window Setup
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
})
end

--RESIZE=====================================================================================================

--Renders the virtual size of the game according to its size
function love.resize(w, h)
    push:resize(w, h)
end

--KEYPRESSED=================================================================================================
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--DRAW=======================================================================================================
function love.draw()
    --Start Virtual Resolution Rendering (NEW!)
    push:start() --push:apply('start')

    --Displays Background
    love.graphics.draw(background, 0, 0)

    --Displays Ground
    love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)

    push:finish() --push:apply('end')
    --End Virtual Resolution Rendering
end