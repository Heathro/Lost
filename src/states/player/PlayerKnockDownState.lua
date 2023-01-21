--[[
    PlayerKnockDownState
]]

PlayerKnockDownState = Class{__includes = BaseState}

function PlayerKnockDownState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -9 or 9
    self.player.low = true
    self.player.knocked = true

    self.player.texture = gTextures['knock_down']
    self.knockDownAnimation = Animation(gPlayerAnimations['knock_down'])
    self.player.animation = self.knockDownAnimation
    self.player.animation:refresh()

    gSounds['knock']:play()
end

function PlayerKnockDownState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -9

        self.player.dx = self.player.dx - self.player.world.deceleration
        if self.player.dx < 0 then
            self.player.dx = 0
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 9

        self.player.dx = self.player.dx + self.player.world.deceleration
        if self.player.dx > 0 then
            self.player.dx = 0
        end

    end

    self.player.dy = self.player.dy + self.player.world.gravity

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkLandingCollision()
    self.player:checkBottomCollision()
    self.player:checkSideCollision()

    if self.player.animation.timesPlayed > 0 then
        Event.dispatch('knock')
    end

    if love.keyboard.wasPressed(JUMP_FLIP_GETUP) then
        self.player.state:change('get_up', self.player)
        
    end

end

function PlayerKnockDownState:exit()
    self.player.offsetX = 0
    self.player.low = false
    self.player.knocked = false
end