--[[
    DeathState
]]

DeathState = Class{__includes = BaseState}

function DeathState:init(params)
    self.playerHealth = params.playerHealth
    self.playerMana = params.playerMana
    self.playerArmor = params.playerArmor
    self.playerAgility = params.playerAgility
    self.playerStrength = params.playerStrength
    self.playerArrows = params.playerArrows
end

function DeathState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        gSounds['click']:play()

        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, FADE_IN_SPEED, 0,
        function()
            gStateStack:pop()
            
            gStateStack:push(PlayState {
                playerHealth = self.playerHealth,
                playerMana = self.playerMana,
                playerArmor = self.playerArmor,
                playerAgility = self.playerAgility,
                playerStrength = self.playerStrength,
                playerArrows = self.playerArrows
            })

            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, FADE_OUT_SPEED,
            function() end))
        end))
    end
end

function DeathState:render()
    local deathBackground = 1
    if LEVEL <= 2 then deathBackground = 1
    elseif LEVEL <= 4 then deathBackground = 2
    elseif LEVEL <= 6 then deathBackground = 3
    elseif LEVEL <= 8 then deathBackground = 4
    elseif LEVEL <= 10 then deathBackground = 5
    elseif LEVEL <= 12 then deathBackground = 6
    end

    love.graphics.draw(gTextures['background1_night_' .. tostring(deathBackground)], 0, 0)
    love.graphics.draw(gTextures['background2_night_' .. tostring(deathBackground)], 0, 0)
    love.graphics.draw(gTextures['background3_night_' .. tostring(deathBackground)], 0, 0)
    love.graphics.draw(gTextures['background4_night_' .. tostring(deathBackground)], 0, 0)
    love.graphics.draw(gTextures['foreground_' .. tostring(deathBackground)], 0, 0)

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('YOU DIED', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, 260, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end