--With Background Scrolling, Ground Scrolling, Backgroung moving speed, ground moving speed, bird (class)

push = require 'push'

Class = require 'class'

require 'Bird'

--===========================================================================================================

WIDTH = 1280
HEIGHT = 680

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--===========================================================================================================

--Background >> local function prevents the variables to be accesible globally
local background = love.graphics.newImage('background.png') --Total width is 1157
--NEW!
local backgroundScrolling = 0 --Keeps track of the scroll

local ground = love.graphics.newImage('ground.png')  --Total width is 1100
--NEW!
local groundScrolling = 0

--NEW!
--Scrolling speed >> RATE OF MOVEMENT
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 90

local BACKGROUND_LOOPING_POINT = 415 --It will loop once the 1/4 part of the image is on 0 x-axis

--NEW!
--Bird
local  bird = Bird()

--LOAD=======================================================================================================
function love.load()
    --Virtual Filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --Window Title
    love.window.setTitle('Flappy Bird')

    --Window Setup (WITH VIRTUAL SCREEN RESOLUTION)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
})
end

--RESIZE=====================================================================================================
function love.resize(w, h)
    push:resize(w, h)
end

--KEYPRESSED=================================================================================================
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--UPDATE=====================================================================================================
function love.update(dt)
    -->>NEW!
    --Background Looping (the modulus is the key to loop the image)
    backgroundScrolling = (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    --Ground Looping
    groundScrolling =  (groundScrolling + GROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    --The modulo is repeating the (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt)
    --To its original value which will display the image again
end

--DRAW=======================================================================================================
function love.draw()
    --Start Virtual Resolution Rendering (NEW!)
    push:start()

    --Displays Background (Update: backgroundScrolling is used as x-axis which is affected from the love.update)
    love.graphics.draw(background, -backgroundScrolling, 0)

    --Displays Ground (Update: groundScrolling is used as x-axis)
    love.graphics.draw(ground, -groundScrolling, VIRTUAL_HEIGHT - 16)

    -->>NEW!
    bird:render()

    push:finish()
    --End Virtual Resolution Rendering
end