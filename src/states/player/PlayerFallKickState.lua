--[[
    PlayerFallKickState
]]

PlayerFallKickState = Class{__includes = BaseState}

function PlayerFallKickState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -5 or 5
    self.player.up = true

    self.player.texture = gTextures['fall_kick']
    self.fallKickAnimation = Animation(gPlayerAnimations['fall_kick'])
    self.player.animation = self.fallKickAnimation
    self.player.animation:refresh()
end

function PlayerFallKickState:update(dt)
    
    if self.player.direction == 'left' then
        self.player.offsetX = -5

        self.player.world.hitboxes = {}
        local fallKickBox = Hitbox {
            world = self.player.world,
            x = self.player.x - 2,
            y = self.player.y + 29,
            xUpdate = -2,
            yUpdate = 29,
            width = 9,
            height = 4,
            type = FALL_KICK_DAMAGE
        }
        table.insert(self.player.world.hitboxes, fallKickBox)

    else
        self.player.offsetX = 5

        self.player.world.hitboxes = {}
        local fallKickBox = Hitbox {
            world = self.player.world,
            x = self.player.x + 13,
            y = self.player.y + 29,
            xUpdate = 13,
            yUpdate = 29,
            width = 9,
            height = 4,
            type = FALL_KICK_DAMAGE
        }
        table.insert(self.player.world.hitboxes, fallKickBox)

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
    self.player:checkLandingCollision()
    self.player:checkSideCollision()    

end

function PlayerFallKickState:exit()
    self.player.offsetX = 0
    self.player.up = false
    self.player.world.hitboxes = {}
end