--[[
    PlayerFinishAttackState
]]

PlayerFinishAttackState = Class{__includes = BaseState}

function PlayerFinishAttackState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -15 or 15
    self.player.offsetY = 6

    self.player.texture = gTextures['finish_attack']
    self.finishAttackAnimation = Animation(gPlayerAnimations['finish_attack'])
    self.player.animation = self.finishAttackAnimation
    self.player.animation:refresh()
end

function PlayerFinishAttackState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -15

        self.player.dx = self.player.dx + self.player.world.deceleration * 4
        if self.player.dx > 0 then
            self.player.dx = 0
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 15

        self.player.dx = self.player.dx - self.player.world.deceleration * 4
        if self.player.dx < 0 then
            self.player.dx = 0
        end

    end
    
    if self.player.animation.currentFrame == 1 then

        gSounds['finish_attack']:stop()
        gSounds['finish_attack']:play()

        local finishAttackBox = Hitbox {
            world = self.player.world,
            x = self.player.x - 35,
            y = self.player.y + 15,
            xUpdate = -35,
            yUpdate = 15,
            width = 90,
            height = 15,
            type = FINISH_ATTACK_DAMAGE
        }
        table.insert(self.player.world.hitboxes, finishAttackBox)

    else
        self.player.world.hitboxes = {}

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

function PlayerFinishAttackState:exit()
    self.player.world.hitboxes = {}
    self.player.offsetX = 0
    self.player.offsetY = 0
end