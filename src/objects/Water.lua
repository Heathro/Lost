--[[
    Water
]]

Water = Class{}

function Water:init()
    self.width = 6400
    self.height = 30

    self.x = 0
    self.y = 338

    self.texture = gTextures['water']
    self.animation = Animation {
        frames = {1, 2, 3},
        interval = 0.2,
        looping = true,
        texture = 'water'
    }
end

function Water:update(dt)
    self.animation:update(dt)
end

function Water:render()
    love.graphics.draw(gTextures['water'], gObjects['water'][self.animation.currentFrame], self.x, self.y)
end