--[[
    HowToPlayState
]]

HowToPlayState = Class{__includes = BaseState}

function HowToPlayState:update(dt)
    if love.keyboard.wasPressed('enter') or 
        love.keyboard.wasPressed('return') or
        love.keyboard.wasPressed('space') or 
        love.keyboard.wasPressed('escape') then

        gSounds['click']:play()

        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, FADE_IN_SPEED, 0,
        function()
            gStateStack:pop()
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, FADE_OUT_SPEED,
            function() end))
        end))
    end
end

function HowToPlayState:render()
    love.graphics.draw(gTextures['background1_night_1'], 0, 0)
    love.graphics.draw(gTextures['background2_night_1'], 0, 0)
    love.graphics.draw(gTextures['background3_night_1'], 0, 0)
    love.graphics.draw(gTextures['background4_night_1'], 0, 0)
    love.graphics.draw(gTextures['foreground_1'], 0, 0)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 1)    
    love.graphics.printf('How to play', -1, 19, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('How to play', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['menu'])
    love.graphics.printf(HOW_TO_PLAY_TEXT1, 165, 55, VIRTUAL_WIDTH, 'left')
    love.graphics.printf(HOW_TO_PLAY_TEXT2, -165, 55, VIRTUAL_WIDTH, 'right')
    love.graphics.printf(HOW_TO_PLAY_TEXT3, 0, 330, VIRTUAL_WIDTH, 'center')
end