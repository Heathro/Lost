--[[
    PlayerPunchIdleState
]]

PlayerPunchIdleState = Class{__includes = BaseState}

function PlayerPunchIdleState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -4 or 4

    self.player.texture = gTextures['punch_idle']
    self.punchIdleAnimation = Animation(gPlayerAnimations['punch_idle'])
    self.player.animation = self.punchIdleAnimation
    self.player.animation:refresh()
end

function PlayerPunchIdleState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -4

        self.player.dx = self.player.dx + self.player.world.deceleration * 3
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 or 
            self.player.animation.currentFrame == 7 or 
            self.player.animation.currentFrame == 11 then

            gSounds['punch']:stop()
            gSounds['punch']:play()

            local punchIdleBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 12,
                y = self.player.y + 5,
                xUpdate = -12,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = PUNCH_IDLE_DAMAGE
            }
            table.insert(self.player.world.hitboxes, punchIdleBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 4

        self.player.dx = self.player.dx - self.player.world.deceleration * 3
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 or 
            self.player.animation.currentFrame == 7 or 
            self.player.animation.currentFrame == 11 then

            gSounds['punch']:stop()
            gSounds['punch']:play()

            local punchIdleBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = PUNCH_IDLE_DAMAGE
            }
            table.insert(self.player.world.hitboxes, punchIdleBox)

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

function PlayerPunchIdleState:exit()
    self.player.offsetX = 0
    self.player.world.hitboxes = {}
end