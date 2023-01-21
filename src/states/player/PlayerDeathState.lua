--[[
    PlayerDeathState
]]

PlayerDeathState = Class{__includes = BaseState}

function PlayerDeathState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -9 or 9
    self.player.dead = true

    self.player.texture = gTextures['death']
    self.deathAnimation = Animation(gPlayerAnimations['death'])
    self.player.animation = self.deathAnimation
    self.player.animation:refresh()

    gSounds['death']:play()
end

function PlayerDeathState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -9

        self.player.dx = self.player.dx + self.player.world.deceleration
        if self.player.dx > 0 then
            self.player.dx = 0

            if self.player.dy == 0 and self.player.animation.timesPlayed > 0 then
                gStateStack:push(FadeInState({
                    r = 0, g = 0, b = 0
                }, FADE_IN_SPEED, self.player.world.camX,
                function()
                    gStateStack:pop()
                    
                    LIVES = LIVES - 1
                    if LIVES == 0 then
                        gStateStack:push(GameOverState())
                    else
                        gStateStack:push(DeathState {
                            playerHealth = HEALTH_START,
                            playerMana = MANA_DEATH,
                            playerArmor = ARMOR_DEATH,
                            playerAgility = AGILITY_DEATH,
                            playerStrength = STRENGTH_DEATH,
                            playerArrows = self.player.arrows
                        })
                    end
        
                    gStateStack:push(FadeOutState({
                        r = 0, g = 0, b = 0
                    }, FADE_OUT_SPEED,
                    function() end))
                end))
            end
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 9

        self.player.dx = self.player.dx - self.player.world.deceleration
        if self.player.dx < 0 then
            self.player.dx = 0

            if self.player.dy == 0 and self.player.animation.timesPlayed > 0 then
                gStateStack:push(FadeInState({
                    r = 0, g = 0, b = 0
                }, FADE_IN_SPEED, self.player.world.camX,
                function()
                    gStateStack:pop()
                    
                    LIVES = LIVES - 1
                    if LIVES == 0 then
                        gStateStack:push(GameOverState())
                    else
                        gStateStack:push(DeathState {
                            playerHealth = HEALTH_START,
                            playerMana = MANA_DEATH,
                            playerArmor = ARMOR_DEATH,
                            playerAgility = AGILITY_DEATH,
                            playerStrength = STRENGTH_DEATH,
                            playerArrows = self.player.arrows
                        })
                    end
        
                    gStateStack:push(FadeOutState({
                        r = 0, g = 0, b = 0
                    }, FADE_OUT_SPEED,
                    function() end))
                end))       
            end
        end
    end

    self.player.dy = self.player.dy + self.player.world.gravity

    if self.player.animation.timesPlayed > 0 then
        self.player.currentFrame = 6
    end

    self.player:checkLandingCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()
end