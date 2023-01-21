--[[
    GameOverState
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gSounds['click']:play()
        
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
    end
end

function GameOverState:render()
    local gameOverBackGround = 1
    if LEVEL <= 2 then gameOverBackGround = 1
    elseif LEVEL <= 4 then gameOverBackGround = 2
    elseif LEVEL <= 6 then gameOverBackGround = 3
    elseif LEVEL <= 8 then gameOverBackGround = 4
    elseif LEVEL <= 10 then gameOverBackGround = 5
    elseif LEVEL <= 12 then gameOverBackGround = 6
    end

    love.graphics.draw(gTextures['background1_night_' .. tostring(gameOverBackGround)], 0, 0)
    love.graphics.draw(gTextures['background2_night_' .. tostring(gameOverBackGround)], 0, 0)
    love.graphics.draw(gTextures['background3_night_' .. tostring(gameOverBackGround)], 0, 0)
    love.graphics.draw(gTextures['background4_night_' .. tostring(gameOverBackGround)], 0, 0)
    love.graphics.draw(gTextures['foreground_' .. tostring(gameOverBackGround)], 0, 0)

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAME OVER', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, 260, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end