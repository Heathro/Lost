--[[
    PlayerJumpState
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:enter(player)
    self.player = player

    self.player.up = true

    self.player.texture = gTextures['jump']
    self.jumpAnimation = Animation(gPlayerAnimations['jump'])
    self.player.animation = self.jumpAnimation
    self.player.animation:refresh()

    gSounds['jump']:setVolume(0.5)
    gSounds['jump']:stop()
    gSounds['jump']:play()
end

function PlayerJumpState:update(dt)
    
    if self.player.dy > 0 then
        self.player.state:change('fall', self.player)
    end

    if love.keyboard.wasPressed(JUMP_FLIP_GETUP) then
        self.player.dy = -self.player.jumpVelocity
        self.player.state:change('flip', self.player)
    
    elseif love.keyboard.wasPressed(SHOOT) and self.player.arrows > 0 then
        self.player.arrows = self.player.arrows - 1
        self.player.state:change('shoot_jump', self.player)
                
    elseif love.keyboard.wasPressed(SPELL) and self.player.mana >= SPELL_REQUIRE then
        self.player.mana = self.player.mana - SPELL_REQUIRE
        self.player.state:change('cast_jump', self.player) 
            
    elseif love.keyboard.wasPressed(LARGE_ATTACK) then
        if self.player.swordEquiped and self.player.strength >= SWOOP_ATTACK_REQUIRE then
            self.player.strength = self.player.strength - SWOOP_ATTACK_REQUIRE
            self.player.dy = self.player.dy - self.player.preAttackVelocity
            self.player.state:change('pre_attack', self.player)
        elseif not self.player.swordEquiped and self.player.agility >= FALL_KICK_REQUIRE then
            self.player.agility = self.player.agility - FALL_KICK_REQUIRE
            self.player.dy = self.player.dy - self.player.preKickVelocity
            self.player.state:change('pre_kick', self.player)
        end
        
    elseif love.keyboard.wasPressed(SMALL_ATTACK) then
        if self.player.swordEquiped and self.player.strength >= ATTACK_JUMP_REQUIRE then
            self.player.strength = self.player.strength - ATTACK_JUMP_REQUIRE
            self.player.state:change('attack_jump', self.player) 
        elseif not self.player.swordEquiped and self.player.agility >= FALL_KICK_REQUIRE then
            self.player.agility = self.player.agility - FALL_KICK_REQUIRE
            self.player.dy = self.player.dy - self.player.preKickVelocity
            self.player.state:change('pre_kick', self.player)
        end
        
    elseif love.keyboard.isDown(LEFT) then
        self.player.direction = 'left'
        self.player.dx = -self.player.sideVelocity

    elseif love.keyboard.isDown(RIGHT) then
        self.player.direction = 'right'
        self.player.dx = self.player.sideVelocity

    end    

    self.player.dy = self.player.dy + self.player.world.gravity

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkJumpingCollision()
    self.player:checkHookCollision()
    self.player:checkSideCollision()

end

function PlayerJumpState:exit()
    self.player.up = false
end