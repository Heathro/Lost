--[[
    PlayerSlowState
]]

PlayerSlowState = Class{__includes = BaseState}

function PlayerSlowState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -4 or 4

    self.player.texture = gTextures['slow']
    self.slowAnimation = Animation(gPlayerAnimations['slow'])
    self.player.animation = self.slowAnimation
    self.player.animation:refresh()

    gSounds['slow']:play()
end

function PlayerSlowState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -4

        self.player.dx = self.player.dx + self.player.world.deceleration * 4
        if self.player.dx > 0 then
            self.player.dx = 0
            self.player.state:change('idle', self.player)
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 4

        self.player.dx = self.player.dx - self.player.world.deceleration * 4
        if self.player.dx < 0 then
            self.player.dx = 0
            self.player.state:change('idle', self.player)
        end
    end

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
        self.player.sideVelocity = math.abs(self.player.dx)
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
        
    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()

end

function PlayerSlowState:exit()
    self.player.offsetX = 0
    gSounds['slow']:stop()
end