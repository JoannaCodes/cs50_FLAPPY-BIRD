Bird = Class{}

local GRAVITY = 20
local ANTI_GRAVITY = -5

function Bird:init()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    self.image = love.graphics.newImage('bird.png') -- size: 38 x 24
    self.width = self.image:getWidth() -- gets the width of the image : 38
    self.height = self.image:getHeight() -- gets the height of the image : 24

    --Position
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    --Velocity
    self.dy = 0
end

function Bird:update(dt)
    --Velocity (going down)
    self.dy = self.dy + GRAVITY * dt

    --the new function can be used now globally
    if love.keyboard.wasPressed('space') then
        self.dy = ANTI_GRAVITY
    end

    --Movement from y-axis
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end