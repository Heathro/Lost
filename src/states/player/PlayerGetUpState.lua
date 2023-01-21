--[[
    PlayerGetUpState
]]

PlayerGetUpState = Class{__includes = BaseState}

function PlayerGetUpState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -9 or 9

    self.player.texture = gTextures['get_up']
    self.getUpAnimation = Animation(gPlayerAnimations['get_up'])
    self.player.animation = self.getUpAnimation
    self.player.animation:refresh()

    gSounds['jump']:stop()
    gSounds['jump']:play()
end

function PlayerGetUpState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -9

    elseif self.player.direction == 'right' then
        self.player.offsetX = 9

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

function PlayerGetUpState:exit()
    self.player.offsetX = 0
    gSounds['land']:play()
end