--[[
    TitleState
]]

TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.titleMenu = Menu {
        x = VIRTUAL_WIDTH / 2 - 80,
        y = VIRTUAL_HEIGHT - 140,
        width = 160,
        height = 90,
        panel = false,
        items = {
            {
                text = 'Start game',
                onSelect = function()
                    gStateStack:push(FadeInState({
                        r = 0, g = 0, b = 0
                    }, FADE_IN_SPEED, 0,
                    function()
                        gStateStack:pop()
                        gStateStack:push(PlayState{
                            playerHealth = HEALTH_START,
                            playerMana = MANA_START,
                            playerArmor = ARMOR_START,
                            playerAgility = AGILITY_START,
                            playerStrength = STRENGTH_START,
                            playerArrows = ARROWS_START
                        })
            
                        gStateStack:push(DialogueState(GAME_START_TEXT, 0))
            
                        gStateStack:push(FadeOutState({
                            r = 0, g = 0, b = 0
                        }, FADE_OUT_SPEED,
                        function() end))
                    end))
                end
            },
            {
                text = 'How to play',
                onSelect = function()
                    gStateStack:push(FadeInState({
                        r = 0, g = 0, b = 0
                    }, FADE_IN_SPEED, 0,
                    function()
                        gStateStack:push(HowToPlayState())            
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
end

function TitleState:update(dt)
    self.titleMenu:update(dt)
end

function TitleState:render()
    
    love.graphics.draw(gTextures['background1_day_1'], 0, 0)
    love.graphics.draw(gTextures['background2_day_1'], 0, 0)
    love.graphics.draw(gTextures['background3_day_1'], 0, 0)
    love.graphics.draw(gTextures['background4_day_1'], 0, 0)
    love.graphics.draw(gTextures['foreground_1'], 0, 0)

    love.graphics.setFont(gFonts['title'])
    
    love.graphics.setColor(0, 0, 0, 1)    
    love.graphics.printf('LOST', -4, 86, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)    
    love.graphics.printf('LOST', -2, 88, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('LOST', 0, 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)    
    love.graphics.printf('LOST', 2, 92, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('LOST', 4, 94, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    self.titleMenu:render()
end