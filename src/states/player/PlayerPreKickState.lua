--[[
    PlayerPreKickState
]]

PlayerPreKickState = Class{__includes = BaseState}

function PlayerPreKickState:enter(player)
    self.player = player

    self.player.up = true

    self.player.texture = gTextures['pre_kick']
    self.preKickAnimation = Animation(gPlayerAnimations['pre_kick'])
    self.player.animation = self.preKickAnimation
    self.player.animation:refresh()
end

function PlayerPreKickState:update(dt)

    if self.player.dy > 0 then
        self.player.state:change('fall_kick', self.player)
    end    

    if love.keyboard.isDown(LEFT) then
        self.player.direction = 'left'
        self.player.dx = -self.player.sideVelocity

    elseif love.keyboard.isDown(RIGHT) then
        self.player.direction = 'right'
        self.player.dx = self.player.sideVelocity

    end

    self.player.dy = self.player.dy + self.player.world.gravity

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()    
    self.player:checkJumpingCollision()
    self.player:checkSideCollision()

end

function PlayerPreKickState:exit()
    self.player.up = false
end