--[[
    Hitbox
]]

Hitbox = Class{}

function Hitbox:init(def)
    self.world = def.world
    self.x = def.x
    self.y = def.y
    self.xUpdate = def.xUpdate
    self.yUpdate = def.yUpdate
    self.width = def.width
    self.height = def.height
    self.type = def.type
end

function Hitbox:update(dt)
    self.x = self.world.player.x + self.xUpdate
    self.y = self.world.player.y + self.yUpdate
end

function Hitbox:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end