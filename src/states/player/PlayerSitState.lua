--[[
    PlayerSitState
]]

PlayerSitState = Class{__includes = BaseState}

function PlayerSitState:enter(player)
    self.player = player

    self.player.low = true

    self.player.texture = gTextures['sit']
    self.sitAnimation = Animation(gPlayerAnimations['sit'])
    self.player.animation = self.sitAnimation
    self.player.animation:refresh()
end

function PlayerSitState:update(dt)
    
    if love.keyboard.isDown(SIT_CROUCH_SLIDE) then

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
            self.player.sideVelocity = self.player.crouchSpeed * 1.5
            self.player.state:change('jump', self.player)
            
        elseif love.keyboard.wasPressed(SHOOT) and self.player.arrows > 0 then
            self.player.arrows = self.player.arrows - 1
            self.player.state:change('shoot_ground', self.player)
            
        elseif love.keyboard.wasPressed(SPELL) and self.player.mana >= SPELL_REQUIRE then
            self.player.mana = self.player.mana - SPELL_REQUIRE
            self.player.state:change('cast_ground', self.player)
            
        elseif love.keyboard.wasPressed(LARGE_ATTACK) then
            if self.player.swordEquiped then 
                
                if self.player.strength >= ATTACK_DOWN_REQUIRE then
                    self.player.strength = self.player.strength - ATTACK_DOWN_REQUIRE
                    self.player.state:change('attack_down', self.player)
                else
                    self.player.state:change('attack_up', self.player)
                end

            else
                
                if self.player.agility >= KICK_REQUIRE then
                    self.player.agility = self.player.agility - KICK_REQUIRE
                    self.player.state:change('kick', self.player)
                else
                    self.player.state:change('punch_idle', self.player)
                end

            end 
            
        elseif love.keyboard.wasPressed(SMALL_ATTACK) then
            if self.player.swordEquiped then
                self.player.state:change('attack_up', self.player)
            else
                self.player.state:change('punch_idle', self.player)
            end 
            
        elseif love.keyboard.isDown(LEFT) then
            self.player.dx = -self.player.crouchSpeed
            self.player.direction = 'left'
            self.player.state:change('crouch', self.player)

        elseif love.keyboard.isDown(RIGHT) then
            self.player.dx = self.player.crouchSpeed
            self.player.direction = 'right'
            self.player.state:change('crouch', self.player)

        else
            self.player.dx = 0

        end

    else
        self.player.dx = 0
        self.player.state:change('idle', self.player)

    end
    
    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    
end

function PlayerSitState:exit()
    self.player.low = false
end