--[[
    LogoState
]]

LogoState = Class{__includes = BaseState}

function LogoState:init()
    self.logo = false

    Timer.after(1, function ()

        self.logo = true
        gStateStack:push(FadeOutState({
            r = 0, g = 0, b = 0
        }, FADE_OUT_SPEED,
        function()

        end)) 
        Timer.after(3, function ()

            gStateStack:push(FadeInState({
                r = 0, g = 0, b = 0
            }, FADE_IN_SPEED, 0,
            function()

                gStateStack:pop()
                gStateStack:push(TitleState())
                gStateStack:push(FadeOutState({
                    r = 0, g = 0, b = 0
                }, FADE_OUT_SPEED,
                function() end))

            end)) 
        end) 
    end)     

    gSounds['select']:setVolume(0.2)
    gSounds['click']:setVolume(0.2)
    gSounds['pause_in']:setVolume(0.2)
    gSounds['pause_out']:setVolume(0.2)

    gSounds['menu']:setLooping(true)
    gSounds['menu']:play()
end

function LogoState:render()
    if self.logo then
        
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.setFont(gFonts['small'])  
        love.graphics.printf('Made with', -26, 173, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['medium'])  
        love.graphics.printf('LOVE', -20, 180, VIRTUAL_WIDTH, 'center')

        love.graphics.draw(gTextures['logo'], 328, 170)
    end
end