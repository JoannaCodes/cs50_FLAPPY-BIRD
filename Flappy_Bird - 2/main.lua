--With Gravity and anti-gravity

push = require 'push'

Class = require 'class'

--Bird class
require 'Bird'

--===========================================================================================================

WIDTH = 1280
HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--===========================================================================================================

--Background >> local function prevents the variables to be accesible globally
local background = love.graphics.newImage('background.png') --total width is 1157
local backgroundScrolling = 0 -- (Keeps track of the scroll)

local ground = love.graphics.newImage('ground.png')  --total width is 1100
local groundScrolling = 0

--Scrolling speed >> RATE OF MOVEMENT
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 90

local BACKGROUND_LOOPING_POINT = 415 --it will loop once the 1/4 part of the image is on 0 x-axis

--Bird
local  bird = Bird()

--LOAD=======================================================================================================
function love.load()
    --Virtual Filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --Window Title
    love.window.setTitle('Flappy Bird')

    --Fonts
    largeFont = love.graphics.newFont('Pixeldraw-0Mxv.ttf', 32)

    --Window Setup (WITH VIRTUAL SCREEN RESOLUTION)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
    })

    --NEW! A new table that will define user input when a key is pressed
    love.keyboard.keysPressed = {}
end

--RESIZE=====================================================================================================
function love.resize(w, h)
    push:resize(w, h)
end

--KEYPRESSED=================================================================================================
function love.keypressed(key)
    --the table will store the keys pressed from the key parameter
    --then it will be set to true
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--NEW! custom function created that will define a 'key' parameter
function love.keyboard.wasPressed(key)
    --checks weather a key WAS PRESSED then it will be set to true
    return love.keyboard.keysPressed[key] == true
end

--UPDATE=====================================================================================================
function love.update(dt)
    --Background Looping (the modulus is the key to loop the image)
    backgroundScrolling = (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    --Ground Looping
    groundScrolling =  (groundScrolling + GROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    -- the modulo is repeating the (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt)
    -- to its original value which will display the image again

    bird:update(dt)

    --once the cheking of a frame is done the table should reset, then will take another key input
    love.keyboard.keysPressed = {}
end

--DRAW=======================================================================================================
function love.draw()
    --Start Virtual Resolution Rendering
    push:start()

    --Displays Background
    love.graphics.draw(background, -backgroundScrolling, 0)

    --Displays Ground
    love.graphics.draw(ground, -groundScrolling, VIRTUAL_HEIGHT - 16)

    bird:render()

    push:finish()
    --End Virtual Resolution Rendering
end