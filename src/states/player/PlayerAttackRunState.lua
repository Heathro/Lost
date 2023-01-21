--[[
    PlayerAttackRunState
]]

PlayerAttackRunState = Class{__includes = BaseState}

function PlayerAttackRunState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -8 or 8

    self.player.texture = gTextures['attack_run']
    self.attackRunAnimation = Animation(gPlayerAnimations['attack_run'])
    self.player.animation = self.attackRunAnimation
    self.player.animation:refresh()
end

function PlayerAttackRunState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -8

        self.player.dx = self.player.dx + self.player.world.deceleration * 2
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 then

            gSounds['attack_run']:stop()
            gSounds['attack_run']:play()

            local attackRunBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 25,
                y = self.player.y + 5,
                xUpdate = -25,
                yUpdate = 5,
                width = 25,
                height = 23,
                type = ATTACK_RUN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackRunBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 8

        self.player.dx = self.player.dx - self.player.world.deceleration * 2
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 then

            gSounds['attack_run']:stop()
            gSounds['attack_run']:play()

            local attackRunBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 5,
                width = 25,
                height = 23,
                type = ATTACK_RUN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackRunBox)

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

function PlayerAttackRunState:exit()
    self.player.offsetX = 0
    self.player.world.hitboxes = {}
end