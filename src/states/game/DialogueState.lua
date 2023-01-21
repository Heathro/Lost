--[[
    DialogueState
]]

DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, xPos, callback)
    self.xPos = xPos
    self.textbox = Textbox(6 + self.xPos, VIRTUAL_HEIGHT - 51, VIRTUAL_WIDTH - 12, 47, text, true)
    self.callback = callback or function() end
    gSounds['footsteps_slow']:pause()
    gSounds['footsteps_fast']:pause()
end

function DialogueState:update(dt)
    self.textbox:update(dt)

    if self.textbox.closed then
        self.callback()
        gStateStack:pop()
    end

    if love.keyboard.wasPressed(PAUSE) then
        gStateStack:push(PauseState(self.xPos))
    end
end

function DialogueState:render()
    self.textbox:render()
end