--[[
    PauseState
]]

PauseState = Class{__includes = BaseState}

function PauseState:init(xPos)
    self.xPos = xPos 
    self.pauseMenu = Menu {
        x = VIRTUAL_WIDTH / 2 - 80 + self.xPos ,
        y = VIRTUAL_HEIGHT / 2 - 45,
        width = 160,
        height = 90,
        panel = true,
        items = {
            {
                text = 'Resume',
                onSelect = function()
                    gStateStack:pop()
                end
            },
            {
                text = 'Main menu',
                onSelect = function()
                    gStateStack:pop()

                    gStateStack:push(FadeInState({
                        r = 0, g = 0, b = 0
                    }, FADE_IN_SPEED, self.xPos,
                    function()
                        gStateStack:pop()
            
                        LIVES = 3
                        LEVEL = 1
                        
                        gStateStack:push(TitleState())
            
                        gStateStack:push(FadeOutState({
                            r = 0, g = 0, b = 0
                        }, FADE_OUT_SPEED,
                        function() end))
                    end))
                end
            },
            {
                text = 'Quit game',
                onSelect = function()
                    love.event.quit()
                end
            }
        }
    }

    gSounds['level_' .. (tostring(LEVEL))]:pause()
    gSounds['menu']:play()
    gSounds['pause_in']:play()
end

function PauseState:update(dt)
    self.pauseMenu:update(dt)

    if love.keyboard.wasPressed(PAUSE) then
        gStateStack:pop()
    end
end

function PauseState:render()
    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH + self.xPos, VIRTUAL_HEIGHT)
    self.pauseMenu:render()
end

function PauseState:exit()
    gSounds['menu']:stop()
    gSounds['pause_out']:play()
    gSounds['level_' .. (tostring(LEVEL))]:play()    
end