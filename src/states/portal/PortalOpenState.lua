--[[
    PortalOpenState
]]

PortalOpenState = Class{__includes = BaseState}

function PortalOpenState:enter(portal)
    self.portal = portal
    self.portal.exist = true
    
    self.portal.texture = gTextures['open_' .. tostring(self.portal.portalColor)]
    self.openAnimation = Animation(gPortalAnimations['open_' .. tostring(self.portal.portalColor)])
    self.portal.animation = self.openAnimation
    self.portal.animation:refresh()
end

function PortalOpenState:update(dt)
    if (self.portal.world.player.dx ~= 0 or self.portal.world.player.dy ~= 0)
        and not self.portal.open then
            
        self.portal.state:change('closing', self.portal)

    end

    if self.portal:collides(self.portal.world.player) then   
        
        love.audio.stop()
        gSounds['portal']:play()

        self.portal.world.player.teleports = true 
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, FADE_IN_SPEED, self.portal.world.camX,
        function()
            gStateStack:pop()
            
            if LEVEL == MAX_LEVEL then
                gStateStack:push(FinishState())
            else
                LEVEL = LEVEL + 1

                gStateStack:push(PlayState{
                    playerHealth = self.portal.world.player.health,
                    playerMana = self.portal.world.player.mana,
                    playerArmor = self.portal.world.player.armor,
                    playerAgility = self.portal.world.player.agility,
                    playerStrength = self.portal.world.player.strength,
                    playerArrows = self.portal.world.player.arrows
                })
            end

            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, FADE_OUT_SPEED,
            function() end))
        end))  
    end
end