--[[
    PlayerHangState
]]

PlayerHangState = Class{__includes = BaseState}

function PlayerHangState:enter(player)
    self.player = player

    self.player.world.gravity = 0

    self.player.texture = gTextures['hang']
    self.hangAnimation = Animation(gPlayerAnimations['hang'])
    self.player.animation = self.hangAnimation
    self.player.animation:refresh()
end

function PlayerHangState:update(dt)

    if love.keyboard.wasPressed(PULLUP) then
        self.player.state:change('pull_up', self.player)
        
    elseif love.keyboard.wasPressed(LEFT) and self.player.direction == 'right' then
        self.player.dx = -self.player.unhookVelocity
        self.player.state:change('fall', self.player)

    elseif love.keyboard.wasPressed(RIGHT) and self.player.direction == 'left' then
        self.player.dx = self.player.unhookVelocity
        self.player.state:change('fall', self.player)
    
    else
        self.player.dx = 0
        self.player.dy = 0

    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()

end

function PlayerHangState:exit()
    self.player.world.gravity = GRAVITY
end