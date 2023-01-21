--[[
    PlayerPreAttackState
]]

PlayerPreAttackState = Class{__includes = BaseState}

function PlayerPreAttackState:enter(player)
    self.player = player

    self.player.up = true

    self.player.offsetX = self.player.direction == 'left' and -4 or 4
    self.player.offsetY = 1

    self.player.texture = gTextures['pre_attack']
    self.preAttackAnimation = Animation(gPlayerAnimations['pre_attack'])
    self.player.animation = self.preAttackAnimation
    self.player.animation:refresh()
end

function PlayerPreAttackState:update(dt)
   
    if self.player.dy > 0 then
        self.player.state:change('swoop_attack', self.player)
    end

    if self.player.direction == 'left' then
        self.player.offsetX = -4
    elseif self.player.direction == 'right' then
        self.player.offsetX = 4
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

function PlayerPreAttackState:exit()
    self.player.up = false
    self.player.offsetX = 0
    self.player.offsetY = 0
end