--[[
    PlayerShootFinishState
]]

PlayerShootFinishState = Class{__includes = BaseState}

function PlayerShootFinishState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -6 or 6

    self.player.texture = gTextures['shoot_ground']
    self.shootFinishAnimation = Animation(gPlayerAnimations['shoot_finish'])
    self.player.animation = self.shootFinishAnimation
    self.player.animation:refresh()
end

function PlayerShootFinishState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -6

        self.player.dx = self.player.dx + self.player.world.deceleration * 4
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 and not self.player.launched then
            self.player.launched = true
            gSounds['shoot']:stop()
            gSounds['shoot']:play()
            local arrow = Arrow {
                world = self.player.world,
                x = self.player.x - 11,
                y = self.player.y + 15,
                dx = -ARROW_SPEED
            }
            table.insert(self.player.world.arrows, arrow)
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 6

        self.player.dx = self.player.dx - self.player.world.deceleration * 4
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 and not self.player.launched then
            self.player.launched = true
            gSounds['shoot']:stop()
            gSounds['shoot']:play()
            local arrow = Arrow {
                world = self.player.world,
                x = self.player.x + self.player.width - 5,
                y = self.player.y + 15,
                dx = ARROW_SPEED
            }     
            table.insert(self.player.world.arrows, arrow)   
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

function PlayerShootFinishState:exit()
    self.player.offsetX = 0
end