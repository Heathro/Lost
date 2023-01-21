--[[
    Menu
]]

Menu = Class{}

function Menu:init(def)
    self.panelRequired = def.panel
    self.panel = Panel(def.x, def.y, def.width, def.height)
    
    self.selection = Selection {
        items = def.items,
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height
    }
end

function Menu:update(dt)
    self.selection:update(dt)
end

function Menu:render()
    if self.panelRequired then
        self.panel:render()
    end
    self.selection:render()
end