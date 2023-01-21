--[[
    PlayerWalkState
]]

PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and 1 or -1

    self.player.texture = gTextures['walk']
    self.walkAnimation = Animation(gPlayerAnimations['walk'])
    self.player.animation = self.walkAnimation
    self.player.animation:refresh()

    gSounds['footsteps_slow']:setLooping(true)
    gSounds['footsteps_slow']:setVolume(0.2)
    gSounds['footsteps_slow']:play()
end

function PlayerWalkState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = 1
    else
        self.player.offsetX = -1
    end

    if love.keyboard.wasPressed(SWITCH) then
        if self.player.swordEquiped then
            self.player.swordEquiped = false
            self.player.stance = FIST
        else
            self.player.swordEquiped = true
            self.player.stance = SWORD
        end

    elseif love.keyboard.isDown(RUN) then
        self.player.state:change('run', self.player)
        
    elseif love.keyboard.isDown(SPRINT) then
        self.player.state:change('sprint', self.player)

    elseif love.keyboard.isDown(SIT_CROUCH_SLIDE) then
        self.player.state:change('crouch', self.player)

    elseif love.keyboard.wasPressed(JUMP_FLIP_GETUP) then
        self.player.dy = -self.player.jumpVelocity
        self.player.sideVelocity = self.player.walkSpeed * 1.75
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
        self.player.direction = 'left'
        self.player.dx = -self.player.walkSpeed

    elseif love.keyboard.isDown(RIGHT) then
        self.player.direction = 'right'
        self.player.dx = self.player.walkSpeed

    else
        self.player.dx = 0
        self.player.state:change('idle', self.player)

    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()

end

function PlayerWalkState:exit()
    self.player.offsetX = 0
    gSounds['footsteps_slow']:stop()
end