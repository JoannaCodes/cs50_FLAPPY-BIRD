--With Infinite Pipe, Pair Pipe, Collision

push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

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

--it will loop once the 1/4 part of the image is on 0 x-axis
local BACKGROUND_LOOPING_POINT = 413

--Bird
local bird = Bird()

--(NEW!)
--Pipe table (Pipe image will be stored in here)
local pipePairs = {}

--This will be the looping point (span of time for the pipes to spawn)
local spawnTimer = 0

--Keeps track of the previous pipes that spawned, used for smooth spawning of the pipes
local lastY = -PIPE_HEIGHT + math.random(80) + 20

--(NEW!)
--Scrolling variable to pause the game once it collies with the pipe
local Scrolling = true

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

    --table for storing keyboard keys pressed
    love.keyboard.keysPressed = {}
end

--RESIZE=====================================================================================================
function love.resize(w, h)
    --Manipulates window w/o affecting the vortual resolution
    push:resize(w, h)
end

--KEYPRESSED=================================================================================================
function love.keypressed(key)
    --The table will store the keys pressed from the key parameter
    --Then it will be set to true
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--Custom function that will return true once a it checks of a key was pressed
function love.keyboard.wasPressed(key)
    --Checks weather a key WAS PRESSED then it will be set to true
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--UPDATE=====================================================================================================
function love.update(dt)
    --(NEW!)
    if Scrolling then
        --Background Looping (the modulus is the key to loop the image)
        backgroundScrolling = (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

        --Ground Looping
        groundScrolling =  (groundScrolling + GROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

        --The modulo is repeating the (backgroundScrolling + BACKGROUND_SCROLL_SPEED * dt)
        --To its original value which will display the image again

        --(NEW!)
        --Pipes Spawning
        spawnTimer = spawnTimer + dt

        if spawnTimer > 3 then
            --Gap size
            --No higher than 10px below top edge
            --No lower than 90px from the bottom
            local y = math.max(-PIPE_HEIGHT + 10, 
                    math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            lastY = y

            --Insert method in lua: table.insert(table created, obj to be inserted)
            --PipePair(y)
            --takes on the 'y' (gap) to set the 'y' argument from the PipePair class and then draws the flipped pipe above the gap
            --and the unflipped pipe below the gap
            table.insert(pipePairs, PipePair(y))

            --Reset spawn timer
            spawnTimer = 0
        end

        --Bird movement
        bird:update(dt)

        --Table iteration: for 'index initializer', 'value getter' in pairs(table/array)
        --Iteration will help to display the tables contents
        for k, pair in pairs(pipePairs) do
            --Spawns the pipe images
            pair:update(dt)

            --(NEW!)
            --Pauses the game once the bird collides with the pipes
            for l, pipe in pairs(pair.pipes) do
                if bird:collides(pipe) then
                    Scrolling = false
                end
            end

            --(UPDATED!)
            -- if pipe is no longer visible past left edge, remove it from scene
            if pair.x < -PIPE_WIDTH then
                pair.remove = true
            end
        end

        -- remove any flagged pipes
        -- we need this second loop, rather than deleting in the previous loop, because
        -- modifying the table in-place without explicit keys will result in skipping the
        -- next pipe, since all implicit keys (numerical indices) are automatically shifted
        -- down after a table removal
        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end
    end

    --Reset input table, it will check key inputs again in the next frame
    love.keyboard.keysPressed = {}
end

--DRAW=======================================================================================================
function love.draw()
    --Start Virtual Resolution Rendering
    push:start()

    --Displays Background
    love.graphics.draw(background, -backgroundScrolling, 0)

    --(NEW!)
    --Display pipes
    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    --Displays Ground
    love.graphics.draw(ground, -groundScrolling, VIRTUAL_HEIGHT - 16)

    bird:render()

    push:finish()
    --End Virtual Resolution Rendering
end