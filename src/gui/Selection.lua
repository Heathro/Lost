--[[
    Selection
]]

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y
    self.height = def.height
    self.width = def.width

    self.gapHeight = self.height / #self.items
    self.currentSelection = 1
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') then
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end
        gSounds['select']:stop()
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('down') then
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end
        gSounds['select']:stop()
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()
        gSounds['click']:play()
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - 8

        if i == self.currentSelection then
            love.graphics.draw(gTextures['cursor'], self.x + 7, paddedY)
        end

        love.graphics.setFont(gFonts['menu'])
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf(self.items[i].text, self.x - 1, paddedY - 1, self.width, 'center')
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end