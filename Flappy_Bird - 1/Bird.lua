--(NEW!)
Bird = Class{}

function Bird:init()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    self.image = love.graphics.newImage('bird.png') -- size: 38 x 24
    self.width = self.image:getWidth() -- Gets the width of the image : 38
    self.height = self.image:getHeight() -- Gets the height of the image : 24

    --Position
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end