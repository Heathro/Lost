--[[
    PlayerAttackDownState
]]

PlayerAttackDownState = Class{__includes = BaseState}

function PlayerAttackDownState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -6 or 6

    self.player.texture = gTextures['attack_down']
    self.attackDownAnimation = Animation(gPlayerAnimations['attack_down'])
    self.player.animation = self.attackDownAnimation
    self.player.animation:refresh()
end

function PlayerAttackDownState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -6

        self.player.dx = self.player.dx + self.player.world.deceleration * 3
        if self.player.dx > 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 then

            gSounds['attack_down']:stop()
            gSounds['attack_down']:play()

            local attackDownBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 15,
                y = self.player.y,
                xUpdate = -15,
                yUpdate = 0,
                width = 15,
                height = 30,
                type = ATTACK_DOWN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackDownBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 6

        self.player.dx = self.player.dx - self.player.world.deceleration * 3
        if self.player.dx < 0 then
            self.player.dx = 0
        end

        if self.player.animation.currentFrame == 4 then

            gSounds['attack_down']:stop()
            gSounds['attack_down']:play()
            
            local attackDownBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y,
                xUpdate = self.player.width,
                yUpdate = 0,
                width = 15,
                height = 30,
                type = ATTACK_DOWN_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackDownBox)

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

function PlayerAttackDownState:exit()
    self.player.offsetX = 0
    self.player.world.hitboxes = {}
end