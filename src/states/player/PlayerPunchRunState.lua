--[[
    PlayerPunchRunState
]]

PlayerPunchRunState = Class{__includes = BaseState}

function PlayerPunchRunState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -15 or 15

    self.player.texture = gTextures['punch_run']
    self.punchRunAnimation = Animation(gPlayerAnimations['punch_run'])
    self.player.animation = self.punchRunAnimation
    self.player.animation:refresh()
end

function PlayerPunchRunState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -15

        self.player.dx = self.player.dx + self.player.world.deceleration * 2
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 then

            gSounds['punch_run']:stop()
            gSounds['punch_run']:play()

            local punchRunBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 12,
                y = self.player.y + 5,
                xUpdate = -12,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = PUNCH_RUN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, punchRunBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 15

        self.player.dx = self.player.dx - self.player.world.deceleration * 2
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 then

            gSounds['punch_run']:stop()
            gSounds['punch_run']:play()
            
            local punchRunBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 5,
                width = 12,
                height = 20,
                type = PUNCH_RUN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, punchRunBox)

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

function PlayerPunchRunState:exit()
    self.player.offsetX = 0
    self.player.world.hitboxes = {}
end