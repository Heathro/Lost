--[[
    Bar
]]

Bar = Class{}

function Bar:init(def)
    self.player = def.player
    
    self.xPos = def.xPos
    self.yPos = def.yPos
    self.color = def.color
    self.name = def.name

    self.value = def.value
    self.maxValue = def.maxValue

    self.x = self.player.world.camX + self.xPos
    self.y = self.yPos
    self.width = 100
    self.height = 6
end

function Bar:update()
    self.x = math.floor(self.player.world.camX + 0.5) + self.xPos
    if self.name == 'Health' then
        self.value = self.player.health
        self.maxValue = self.player.maxHealth
    elseif self.name == 'Mana' then
        self.value = self.player.mana
        self.maxValue = self.player.maxMana
    elseif self.name == 'Armor' then
        self.value = self.player.armor
        self.maxValue = self.player.maxArmor
    elseif self.name == 'Agility' then
        self.value = self.player.agility
        self.maxValue = self.player.maxAgility
    elseif self.name == 'Strength' then
        self.value = self.player.strength
        self.maxValue = self.player.maxStrength
    end
end

function Bar:render()
    local renderWidth = (self.value / self.maxValue) * self.width

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    if self.value > 0 then
        love.graphics.rectangle('fill', math.floor(self.x), math.floor(self.y), renderWidth, self.height, 3)
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('line', math.floor(self.x), math.floor(self.y), self.width, self.height, 3)

    love.graphics.setFont(gFonts['small'])
    love.graphics.print(self.name ..' '.. tostring(self.value), math.floor(self.x + self.width + 3), math.floor(self.y))
    love.graphics.setColor(1, 1, 1, 1)
end