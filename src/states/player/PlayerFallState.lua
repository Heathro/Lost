--[[
    PlayerFallState
]]

PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:enter(player)
    self.player = player

    self.player.offsetY = 1
    self.player.up = true

    self.player.texture = gTextures['fall']
    self.fallAnimation = Animation(gPlayerAnimations['fall'])
    self.player.animation = self.fallAnimation
    self.player.animation:refresh()
end

function PlayerFallState:update(dt)
    
    if love.keyboard.wasPressed(SHOOT) and self.player.arrows > 0 then
        self.player.arrows = self.player.arrows - 1
        self.player.state:change('shoot_jump', self.player)
            
    elseif love.keyboard.wasPressed(SPELL) and self.player.mana >= SPELL_REQUIRE then
        self.player.mana = self.player.mana - SPELL_REQUIRE
        self.player.state:change('cast_jump', self.player)  

    elseif love.keyboard.wasPressed(SMALL_ATTACK) then
        if self.player.swordEquiped and self.player.strength >= ATTACK_FALL_REQUIRE then
            self.player.strength = self.player.strength - ATTACK_FALL_REQUIRE
            self.player.state:change('attack_fall', self.player)
        elseif not self.player.swordEquiped and self.player.agility >= FALL_KICK_REQUIRE then
            self.player.agility = self.player.agility - FALL_KICK_REQUIRE
            self.player.state:change('fall_kick', self.player)
        end

    elseif love.keyboard.wasPressed(LARGE_ATTACK) then
        if self.player.swordEquiped and self.player.strength >= SWOOP_ATTACK_REQUIRE then
            self.player.strength = self.player.strength - SWOOP_ATTACK_REQUIRE
            self.player.state:change('swoop_attack', self.player) 
        elseif not self.player.swordEquiped and self.player.agility >= FALL_KICK_REQUIRE then
            self.player.agility = self.player.agility - FALL_KICK_REQUIRE
            self.player.state:change('fall_kick', self.player)
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
    self.player:checkLandingCollision()
    self.player:checkHookCollision()
    self.player:checkSideCollision()    

end

function PlayerFallState:exit()
    self.player.offsetY = 0
    self.player.up = false
end