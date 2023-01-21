--[[
    FinishState
]]

FinishState = Class{__includes = BaseState}

function FinishState:init()
    self.textY = VIRTUAL_HEIGHT + 20
    Timer.tween(60, {
        [self] = {textY = -VIRTUAL_HEIGHT - 70}
    }):finish(function()
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, FADE_IN_SPEED, 0,
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

    end)

    gSounds['level_' .. (tostring(LEVEL))]:stop()
    gSounds['finish']:setLooping(true)
    gSounds['finish']:setVolume(0.4)
    gSounds['finish']:play()
end

function FinishState:render()
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(153/255, 76/255, 0, 1)    
    love.graphics.printf(tostring(CREDITS_TEXT), 0, math.floor(self.textY), VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 128/255, 0, 1)
    love.graphics.printf(tostring(CREDITS_CREATE_TEXT), 0, math.floor(self.textY + 60), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)   
    love.graphics.printf(tostring(CREDITS_CREATE1_TEXT), 0, math.floor(self.textY + 80), VIRTUAL_WIDTH, 'center')

    
    love.graphics.setColor(1, 128/255, 0, 1)
    love.graphics.printf(tostring(CREDITS_ART_TEXT), 0, math.floor(self.textY + 140), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)  
    love.graphics.printf(tostring(CREDITS_ART1_TEXT), 0, math.floor(self.textY + 160), VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(CREDITS_ART2_TEXT), 0, math.floor(self.textY + 170), VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(CREDITS_ART3_TEXT), 0, math.floor(self.textY + 180), VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(CREDITS_ART4_TEXT), 0, math.floor(self.textY + 190), VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(CREDITS_ART5_TEXT), 0, math.floor(self.textY + 200), VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(CREDITS_ART6_TEXT), 0, math.floor(self.textY + 210), VIRTUAL_WIDTH, 'center')

    
    love.graphics.setColor(1, 128/255, 0, 1)
    love.graphics.printf(tostring(CREDITS_SOUND_TEXT), 0, math.floor(self.textY + 270), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)  
    love.graphics.printf(tostring(CREDITS_SOUND1_TEXT), 0, math.floor(self.textY + 290), VIRTUAL_WIDTH, 'center')

    
    love.graphics.setColor(1, 128/255, 0, 1)
    love.graphics.printf(tostring(CREDITS_MUSIC_TEXT), 0, math.floor(self.textY + 350), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)  
    love.graphics.printf(tostring(CREDITS_MUSIC1_TEXT), 0, math.floor(self.textY + 370), VIRTUAL_WIDTH, 'center')

    love.graphics.printf(tostring(CREDITS_END_TEXT), 0, math.floor(self.textY + 570), VIRTUAL_WIDTH, 'center')
end

function FinishState:exit()
    gSounds['finish']:stop()
    gSounds['menu']:play()    
end