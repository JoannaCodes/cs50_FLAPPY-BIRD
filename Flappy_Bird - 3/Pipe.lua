--(NEW!)
Pipe = Class{}

local PIPE = love.graphics.newImage('pipe.png')

PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

--Takes on argument 'orientation' and 'y'
function Pipe:init(orientation, y)
    --Places the pipes on the right egde (invisible at first)
    self.x = VIRTUAL_WIDTH

    --Spawns the pipes in random heigth with math.random(min, max), it does not spawn randomly now
    --Takes value form the 'y' argument
    self.y = y

    --Sets width from the image
    self.width = PIPE:getWidth()
    self.heigth = PIPE_HEIGHT

    --Takes on 'top' or 'bottom'
    --Takes value form the 'orientation' argument
    self.orientation = orientation
end

function Pipe:render()
    --Displays Pipes
    --                               TRUE    FALSE                 TRUE    FALSE
    --Ternary operators: condition ? expr1 : expr2 = condition and expr1 or expr2
    love.graphics.draw(PIPE, self.x, 
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), 
        0, --Rotation
        1, --X Scale
        self.orientation == 'top' and -1 or 1)--Y Scale, shifts the pipe
end