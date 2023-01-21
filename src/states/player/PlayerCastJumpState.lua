--[[
    PlayerCastJumpState
]]

PlayerCastJumpState = Class{__includes = BaseState}

function PlayerCastJumpState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -1 or 1   
    self.player.casted = false

    self.player.texture = gTextures['cast']
    self.castJumpAnimation = Animation(gPlayerAnimations['cast_jump'])
    self.player.animation = self.castJumpAnimation
    self.player.animation:refresh()
end

function PlayerCastJumpState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -1
        
        if self.player.animation.currentFrame == 3 and not self.player.casted then
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
        
        if self.player.animation.currentFrame == 3 and not self.player.casted then
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
        self.player.state:change('fall', self.player)
    end

    self.player.dy = self.player.dy + self.player.world.gravity

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkJumpingCollision()
    self.player:checkLandingCollision()
    self.player:checkSideCollision()

end

function PlayerCastJumpState:exit()
    self.player.offsetX = 0
end