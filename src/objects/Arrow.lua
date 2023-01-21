--[[
    Arrow
]]

Arrow = Class{}

function Arrow:init(def)
    self.world = def.world

    self.x = def.x
    self.y = def.y

    self.dx = def.dx

    self.width = 16
    self.height = 1
end

function Arrow:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end

function Arrow:update(dt)
    self.x = self.x + self.dx * dt
end

function Arrow:render()
    love.graphics.draw(gTextures['items'], gObjects['items'][351],
        math.floor(self.x), math.floor(self.y))
end