--[[
    Fireball
]]

Fireball = Class{}

function Fireball:init(def)
    self.world = def.world

    self.x = def.x
    self.y = def.y

    self.dx = def.dx
    self.direction = def.direction

    self.width = 18
    self.height = 9

    self.texture = gTextures['fireball']
    self.animation = Animation {
        frames = {1, 2, 3, 4},
        interval = 0.1,
        looping = true,
        texture = 'fireball'
    }
end

function Fireball:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or
            target.y > self.y + self.height or self.y > target.y + target.height)
end

function Fireball:update(dt)
    self.animation:update(dt)
    self.x = self.x + self.dx * dt
end

function Fireball:render()
    love.graphics.draw(self.texture,
        gObjects[self.animation.texture][self.animation:getCurrentFrame()], 
        math.floor(self.x + self.width / 2),
        math.floor(self.y + self.height / 2),
        0, 
        self.direction == 'left' and -1 or 1,
        1,
        self.width / 2, self.height / 2)
end