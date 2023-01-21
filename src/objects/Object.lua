--[[
    Object
]]

Object = Class{}

function Object:init(def)
    self.x = def.x * TILE_SIZE - TILE_SIZE
    self.y = def.y * TILE_SIZE - TILE_SIZE
    self.type = def.type

    self.width = 16
    self.height = 16

    self.frame = gObjectFrame[tostring(self.type)]
    self.onConsume = gObjectConsume[tostring(self.type)]
    self.restorable = self.type ~= 'life'
    self.hidden = false
end

function Object:collides(player)
    return not (player.x > self.x + self.width or self.x > player.x + player.width or
            player.y > self.y + self.height or self.y > player.y + player.height)
end

function Object:update(dt)

end

function Object:render()
    if not self.hidden then
        love.graphics.draw(gTextures['items'], gObjects['items'][self.frame], self.x, self.y)
    end
end