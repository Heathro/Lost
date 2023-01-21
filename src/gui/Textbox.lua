--[[
    Textbox
]]

Textbox = Class{}

function Textbox:init(x, y, width, height, text, avatar)
    self.panel = Panel(x, y, width, height, avatar)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.closed = false
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.panel:toggle()
        self.closed = true
    end
end

function Textbox:render()
    self.panel:render()    
    love.graphics.setFont(gFonts['small'])
    love.graphics.print(self.text, self.x + 49, self.y + 6)
    love.graphics.print(INSTRUCTION_TEXT, self.x + self.width - 105, self.y + self.height - 10)
end