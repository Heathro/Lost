--[[
    PlayerCastGroundState
]]

PlayerCastGroundState = Class{__includes = BaseState}

function PlayerCastGroundState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -1 or 1    
    self.player.casted = false

    self.player.texture = gTextures['cast']
    self.castGroundAnimation = Animation(gPlayerAnimations['cast_ground'])
    self.player.animation = self.castGroundAnimation
    self.player.animation:refresh()
end

function PlayerCastGroundState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -1

        self.player.dx = self.player.dx + self.player.world.deceleration * 4
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 and not self.player.casted then
            self.player.casted = true
            gSounds['spell']:stop()
            gSounds['spell']:play()
            local fireball = Fireball {
                world = self.player.world,
                x = self.player.x - 18,
                y = self.player.y + 10,
                dx = -FIREBALL_SPEED,
                direction = 'left'
            }
            table.insert(self.player.world.fireballs, fireball)
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 1

        self.player.dx = self.player.dx - self.player.world.deceleration * 4
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 and not self.player.casted then
            self.player.casted = true
            gSounds['spell']:stop()
            gSounds['spell']:play()
            local fireball = Fireball {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 10,
                dx = FIREBALL_SPEED,
                direction = 'right'
            }     
            table.insert(self.player.world.fireballs, fireball)
        end

    end

    if self.player.animation.timesPlayed > 0 then
        self.player.state:change('idle', self.player)
    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()

end

function PlayerCastGroundState:exit()
    self.player.offsetX = 0
end