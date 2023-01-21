--[[
    GameplayUI
]]

GameplayUI = Class{}

function GameplayUI:init(player)
    self.player = player

    self.popups = {}

    -- bars
    self.healthBar = Bar {
        player = self.player,
        value = self.player.health, maxValue = self.player.maxHealth,
        xPos = 10, yPos = 10, name = 'Health',
        color = {r = 235/255, g = 48/255, b = 48/255}
    }
    self.manaBar = Bar {
        player = self.player,
        value = self.player.mana, maxValue = self.player.maxMana,
        xPos = 10, yPos = 19, name = 'Mana',
        color = {r = 38/255, g = 107/255, b = 168/255}
    }
    self.armorBar = Bar {
        player = self.player,
        value = self.player.armor, maxValue = self.player.maxArmor,
        xPos = 10, yPos = 28, name = 'Armor',
        color = {r = 50/255, g = 140/255, b = 30/255}
    }
    self.agilityBar = Bar {
        player = self.player,
        value = self.player.agility, maxValue = self.player.maxAgility,
        xPos = 10, yPos = 37, name = 'Agility',
        color = {r = 234/255, g = 93/255, b = 38/255}
    }
    self.strengthBar = Bar {
        player = self.player,
        value = self.player.strength, maxValue = self.player.maxStrength,
        xPos = 10, yPos = 45, name = 'Strength',
        color = {r = 133/255, g = 60/255, b = 198/255}
    }
    -- icons
    self.stanceIcon = Icon {
        player = self.player,
        xIcon = 165, yIcon = 11, xNum = 0, yNum = 0,
        frame = self.player.stance, name = 'stance'
    }
    self.healthIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 37, yIcon = 4, xNum = -13, yNum = 6,
        frame = gObjectFrame['life'], name = 'heart', value = LIVES
    }
    self.arrowIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 86, yIcon = 4, xNum = -13, yNum = 6,
        frame = gObjectFrame['arrow'], name = 'arrow', value = self.player.arrows
    }
    self.shoeIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 138, yIcon = 6, xNum = -15, yNum = 4,
        frame = self.player.acceleratedType, name = 'shoe',
        value = math.floor(self.player.acceleratedDuration - self.player.acceleratedTimer)
    }
    self.inviolableIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 187, yIcon = 5, xNum = -15, yNum = 6,
        frame = self.player.inviolableType, name = 'inviolable',
        value = math.floor(self.player.invulnerableDuration - self.player.invulnerableTimer)
    }
    self.enlargeLightIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 240, yIcon = 5, xNum = -16, yNum = 6,
        frame = gObjectFrame['yellow_scroll'], name = 'enlargeLight',
        value = math.floor(self.player.enlargeLightDuration - self.player.enlargeLightTimer)
    }
    self.cursedIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 292, yIcon = 5, xNum = -16, yNum = 6,
        frame = gObjectFrame['black_scroll'], name = 'cursed',
        value = math.floor(self.player.cursedDuration - self.player.cursedTimer)
    }
    self.invisibleIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 340, yIcon = 5, xNum = -13, yNum = 6,
        frame = self.player.invisibleType, name = 'invisible',
        value = math.floor(self.player.invisibleDuration - self.player.invisibleTimer)
    }
    self.eatingIcon = Icon {
        player = self.player,
        xIcon = VIRTUAL_WIDTH - 390, yIcon = 5, xNum = -16, yNum = 6,
        frame = self.player.eatingType, name = 'eating',
        value = math.floor(self.player.eatingDuration - self.player.eatingTimer)
    }
end

function GameplayUI:update(dt)
    for p, popup in pairs(self.popups) do
        popup:update(dt)
    end
    self.stanceIcon:update(dt)
    self.eatingIcon:update(dt)
    self.invisibleIcon:update(dt)
    self.cursedIcon:update(dt)
    self.enlargeLightIcon:update(dt)
    self.agilityBar:update(dt)
    self.strengthBar:update(dt)
    self.arrowIcon:update(dt)
    self.shoeIcon:update(dt)
    self.inviolableIcon:update(dt)
    self.healthIcon:update(dt)
    self.manaBar:update(dt)
    self.healthBar:update(dt)
    self.armorBar:update(dt)
end

function GameplayUI:render()
    for p, popup in pairs(self.popups) do
        popup:render()
    end
    
    if self.player.inviolable then
        self.inviolableIcon:render()
    end
    if self.player.accelerated then
        self.shoeIcon:render()
    end
    if self.player.enlargeLight then
        self.enlargeLightIcon:render()
    end
    if self.player.cursed then
        self.cursedIcon:render()
    end
    if self.player.invisible then
        self.invisibleIcon:render()
    end
    if self.player.eating then
        self.eatingIcon:render()
    end

    self.stanceIcon:render()
    self.agilityBar:render()
    self.strengthBar:render()
    self.manaBar:render()
    self.arrowIcon:render()
    self.healthIcon:render()
    self.healthBar:render()
    self.armorBar:render()
end