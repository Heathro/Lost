--[[
    FadeInState
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, time, xPos, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.time = time
    self.xPos = xPos

    Timer.tween(self.time, {
        [self] = {opacity = 1}
    })
    :finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', -10 + self.xPos, 0, VIRTUAL_WIDTH + 20, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end