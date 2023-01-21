--[[
    Icon
]]

Icon = Class{}

function Icon:init(def)
    self.player = def.player
    
    self.xIcon = def.xIcon
    self.yIcon = def.yIcon

    self.xNum = def.xNum
    self.yNum = def.yNum

    self.x = self.player.world.camX + self.xIcon
    self.y = self.yIcon
    self.frame = def.frame

    self.value = def.value
    self.name = def.name
end

function Icon:update(dt)
    self.x = math.floor(self.player.world.camX + 0.5) + self.xIcon
    if self.name == 'heart' then
        self.value = LIVES
    elseif self.name == 'arrow' then
        self.value = self.player.arrows
    elseif self.name == 'inviolable' then
        self.value = math.floor(self.player.invulnerableDuration - self.player.invulnerableTimer)
        self.frame = self.player.inviolableType
    elseif self.name == 'shoe' then
        self.value = math.floor(self.player.acceleratedDuration - self.player.acceleratedTimer)
        self.frame = self.player.acceleratedType
    elseif self.name == 'enlargeLight' then
        self.value = math.floor(self.player.enlargeLightDuration - self.player.enlargeLightTimer)
    elseif self.name == 'cursed' then
        self.value = math.floor(self.player.cursedDuration - self.player.cursedTimer)
    elseif self.name == 'invisible' then
        self.value = math.floor(self.player.invisibleDuration - self.player.invisibleTimer)
        self.frame = self.player.invisibleType
    elseif self.name == 'eating' then
        self.value = math.floor(self.player.eatingDuration - self.player.eatingTimer)
        self.frame = self.player.eatingType
    elseif self.name == 'stance' then
        self.frame = self.player.stance
    end
end

function Icon:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['medium'])
    if self.name ~= 'stance' then
        love.graphics.print(tostring(self.value), math.floor(self.x + self.xNum), math.floor(self.y + self.yNum))
    end
    love.graphics.draw(gTextures['icons'], gObjects['icons'][self.frame], math.floor(self.x), math.floor(self.y))
    love.graphics.setColor(1, 1, 1, 1)
end