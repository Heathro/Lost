--[[
    PlayerRunState
]]

PlayerRunState = Class{__includes = BaseState}

function PlayerRunState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -3 or 3

    self.player.texture = gTextures['run']
    self.runAnimation = Animation(gPlayerAnimations['run'])
    self.player.animation = self.runAnimation
    self.player.animation:refresh()

    gSounds['footsteps_fast']:setLooping(true)
    gSounds['footsteps_fast']:setVolume(0.2)
    gSounds['footsteps_fast']:play()
end

function PlayerRunState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -3
    else
        self.player.offsetX = 3
    end
    
    if love.keyboard.isDown(RUN) then

        if love.keyboard.wasPressed(SWITCH) then
            if self.player.swordEquiped then
                self.player.swordEquiped = false
                self.player.stance = FIST
            else
                self.player.swordEquiped = true
                self.player.stance = SWORD
            end
        
        elseif love.keyboard.wasPressed(JUMP_FLIP_GETUP) then
            self.player.dy = -self.player.jumpVelocity
            self.player.sideVelocity = self.player.runSpeed
            self.player.state:change('jump', self.player)
            
        elseif love.keyboard.wasPressed(SHOOT) and self.player.arrows > 0 then
            self.player.arrows = self.player.arrows - 1
            self.player.state:change('shoot_ground', self.player)
                    
        elseif love.keyboard.wasPressed(SPELL) and self.player.mana >= SPELL_REQUIRE then
            self.player.mana = self.player.mana - SPELL_REQUIRE
            self.player.state:change('cast_ground', self.player)  

        elseif love.keyboard.wasPressed(LARGE_ATTACK) then
            if self.player.swordEquiped then
                
                if self.player.strength >= ATTACK_RUN_REQUIRE then
                    self.player.strength = self.player.strength - ATTACK_RUN_REQUIRE
                    self.player.state:change('attack_run', self.player)
                else
                    self.player.state:change('attack_up', self.player)
                end

            else
                
                if self.player.agility >= PUNCH_RUN_REQUIRE then
                    self.player.agility = self.player.agility - PUNCH_RUN_REQUIRE
                    self.player.state:change('punch_run', self.player)
                else
                    self.player.state:change('punch_idle', self.player)
                end
                
            end

        elseif love.keyboard.wasPressed(SMALL_ATTACK) then
            if self.player.swordEquiped then
                if self.player.strength >= ATTACK_RUN_REQUIRE then
                    self.player.strength = self.player.strength - ATTACK_RUN_REQUIRE
                    self.player.state:change('attack_run', self.player)
                else
                    self.player.state:change('attack_up', self.player)
                end
            else
                if self.player.agility >= PUNCH_RUN_REQUIRE then
                    self.player.agility = self.player.agility - PUNCH_RUN_REQUIRE
                    self.player.state:change('punch_run', self.player)
                else
                    self.player.state:change('punch_idle', self.player)
                end
            end 

        elseif love.keyboard.wasPressed(SIT_CROUCH_SLIDE) then
            if self.player.agility >= SLIDE_HIT_REQUIRE then
                self.player.agility = self.player.agility - SLIDE_HIT_REQUIRE
                self.player.state:change('slide', self.player)
            else
                self.player.state:change('slow', self.player)
            end

        elseif love.keyboard.isDown(LEFT) then
            self.player.direction = 'left'
            self.player.dx = -self.player.runSpeed

        elseif love.keyboard.isDown(RIGHT) then
            self.player.direction = 'right'
            self.player.dx = self.player.runSpeed

        else
            self.player.state:change('slow', self.player)
            
        end

    else
        self.player.state:change('slow', self.player)

    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()
    
end

function PlayerRunState:exit()
    self.player.offsetX = 0
    gSounds['footsteps_fast']:stop()
end