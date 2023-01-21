--[[
    PlayerSlideState
]]

PlayerSlideState = Class{__includes = BaseState}

function PlayerSlideState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -14 or 14
    self.player.low = true

    self.player.texture = gTextures['slide']
    self.slideAnimation = Animation(gPlayerAnimations['slide'])
    self.player.animation = self.slideAnimation
    self.player.animation:refresh()

    local slideHitBox = Hitbox {
        world = self.player.world,
        x = self.player.direction == 'left' and self.player.x or self.player.x + self.player.width,
        y = self.player.y + 20,
        xUpdate = self.player.direction == 'left' and -4 or self.player.width,
        yUpdate = 20,
        width = 4,
        height = 10,
        type = SLIDE_HIT_DAMAGE
    }
    table.insert(self.player.world.hitboxes, slideHitBox)

    gSounds['slide']:play()
end

function PlayerSlideState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -14

        self.player.dx = self.player.dx + self.player.world.deceleration
        if self.player.dx > 0 then
            self.player.dx = 0
            self.player.state:change('sit', self.player)
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 14

        self.player.dx = self.player.dx - self.player.world.deceleration
        if self.player.dx < 0 then
            self.player.dx = 0
            self.player.state:change('sit', self.player)
        end

    end

    if love.keyboard.wasPressed(JUMP_FLIP_GETUP) then
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

    elseif love.keyboard.isDown(LEFT) and 
        self.player.direction == 'left' and self.player.animation.currentFrame == 5 then
            self.player.state:change('crouch', self.player)

    elseif love.keyboard.isDown(RIGHT) and 
        self.player.direction == 'right' and self.player.animation.currentFrame == 5 then
            self.player.state:change('crouch', self.player)
        
    end

    if self.player.animation.timesPlayed > 0 then
        self.player.currentFrame = 5
    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()

end

function PlayerSlideState:exit()
    self.player.offsetX = 0
    self.player.low = false
    self.player.world.hitboxes = {}
    gSounds['slide']:stop()
end