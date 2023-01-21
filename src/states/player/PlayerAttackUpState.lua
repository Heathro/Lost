--[[
    PlayerAttackUpState
]]

PlayerAttackUpState = Class{__includes = BaseState}

function PlayerAttackUpState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -3 or 3
    self.player.offsetY = 6

    self.player.texture = gTextures['attack_up']
    self.attackUpAnimation = Animation(gPlayerAnimations['attack_up'])
    self.player.animation = self.attackUpAnimation
    self.player.animation:refresh()
end

function PlayerAttackUpState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -3

        self.player.dx = self.player.dx + self.player.world.deceleration * 3
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 then

            gSounds['attack_up']:stop()
            gSounds['attack_up']:play()

            local attackUpBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 15,
                y = self.player.y - 5,
                xUpdate = -15,
                yUpdate = -5,
                width = 15,
                height = 30,
                type = ATTACK_UP_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackUpBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 3

        self.player.dx = self.player.dx - self.player.world.deceleration * 3
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 3 then

            gSounds['attack_up']:stop()
            gSounds['attack_up']:play()

            local attackUpBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y - 5,
                xUpdate = self.player.width,
                yUpdate = -5,
                width = 15,
                height = 30,
                type = ATTACK_UP_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackUpBox)

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

function PlayerAttackUpState:exit()
    self.player.world.hitboxes = {}
    self.player.offsetX = 0
    self.player.offsetY = 0
end