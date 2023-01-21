--[[
    PlayerKickState
]]

PlayerKickState = Class{__includes = BaseState}

function PlayerKickState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -3 or 3

    self.player.texture = gTextures['kick']
    self.kickAnimation = Animation(gPlayerAnimations['kick'])
    self.player.animation = self.kickAnimation
    self.player.animation:refresh()
end

function PlayerKickState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -3

        self.player.dx = self.player.dx + self.player.world.deceleration * 3
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 or self.player.animation.currentFrame == 6 then

            gSounds['kick']:stop()
            gSounds['kick']:play()

            local kickBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 12,
                y = self.player.y + 5,
                xUpdate = -12,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = KICK_DAMAGE
            }
            table.insert(self.player.world.hitboxes, kickBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 3

        self.player.dx = self.player.dx - self.player.world.deceleration * 3
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 or self.player.animation.currentFrame == 6 then

            gSounds['kick']:stop()
            gSounds['kick']:play()
            
            local kickBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = KICK_DAMAGE
            }
            table.insert(self.player.world.hitboxes, kickBox)

        else
            self.player.world.hitboxes = {}

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

function PlayerKickState:exit()
    self.player.offsetX = 0
    self.player.world.hitboxes = {}
end