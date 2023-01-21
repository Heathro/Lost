--[[
    Popup
]]

Popup = Class{}

function Popup:init(def)
    self.player = def.player
    
    self.x = def.x
    self.y = def.y

    self.value = def.value
    self.color = def.color
end

function Popup:update(dt)
    
end

function Popup:render()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print(tostring(self.value), math.floor(self.x), math.floor(self.y))
    love.graphics.setColor(1, 1, 1, 1)
end