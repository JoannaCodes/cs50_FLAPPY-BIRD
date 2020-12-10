--(NEW!)
PipePair = Class{}

--Gap size between upper and lower pipe
local GAP_HEIGHT = 90

--Takes on argument 'y'
function PipePair:init(y)
    --Sets position of the pipes beyond the virtual width
    self.x = VIRTUAL_WIDTH + 32

    --Y position of the upper pipe, gap will be vertically shifted
    --Takes value form the 'y' argument
    self.y = y

    --Sets the value for argument from init in Pipe class: 'Pipe:init(orientation, y)'
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    --Removes pipes one it is beyond the left side of the screen
    self.remove = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end