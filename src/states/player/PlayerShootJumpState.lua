--[[
    PlayerShootJumpState
]]

PlayerShootJumpState = Class{__includes = BaseState}

function PlayerShootJumpState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -3 or 3    
    self.player.launched = false

    self.player.texture = gTextures['shoot_jump']
    self.shootJumpAnimation = Animation(gPlayerAnimations['shoot_jump'])
    self.player.animation = self.shootJumpAnimation
    self.player.animation:refresh()
end

function PlayerShootJumpState:update(dt)
    if self.player.direction == 'left' then
        self.player.offsetX = -3
        
        if self.player.animation.currentFrame == 5 and not self.player.launched then
            self.player.launched = true
            gSounds['shoot']:stop()
            gSounds['shoot']:play()
            local arrow = Arrow {
                world = self.player.world,
                x = self.player.x - 11,
                y = self.player.y + 20,
                dx = -ARROW_SPEED
            }
            table.insert(self.player.world.arrows, arrow)
        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 3
        
        if self.player.animation.currentFrame == 5 and not self.player.launched then
            self.player.launched = true
            gSounds['shoot']:stop()
            gSounds['shoot']:play()
            local arrow = Arrow {
                world = self.player.world,
                x = self.player.x + self.player.width - 5,
                y = self.player.y + 20,
                dx = ARROW_SPEED
            }     
            table.insert(self.player.world.arrows, arrow)   
        end

    end

    if self.player.animation.timesPlayed > 0 then
        self.player.state:change('fall', self.player)
    end

    self.player.dy = self.player.dy + self.player.world.gravity

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()
    self.player:checkJumpingCollision()
    self.player:checkLandingCollision()
    self.player:checkSideCollision()

end

function PlayerShootJumpState:exit()
    self.player.offsetX = 0
end