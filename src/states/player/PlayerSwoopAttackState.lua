--[[
    PlayerSwoopAttackState
]]

PlayerSwoopAttackState = Class{__includes = BaseState}

function PlayerSwoopAttackState:enter(player)
    self.player = player

    self.player.offsetX = self.player.direction == 'left' and -3 or 3
    self.player.offsetY = 1
    self.player.up = true

    self.player.texture = gTextures['swoop_attack']
    self.swoopAttackAnimation = Animation(gPlayerAnimations['swoop_attack'])
    self.player.animation = self.swoopAttackAnimation
    self.player.animation:refresh()
end

function PlayerSwoopAttackState:update(dt)
    
    if self.player.direction == 'left' then
        self.player.offsetX = -3

        self.player.world.hitboxes = {}
        local swoopAttackBox = Hitbox {
            world = self.player.world,
            x = self.player.x - 6,
            y = self.player.y,
            xUpdate = -6,
            yUpdate = 0,
            width = 13,
            height = 34,
            type = SWOOP_ATTACK_DAMAGE
        }
        table.insert(self.player.world.hitboxes, swoopAttackBox)

    else
        self.player.offsetX = 3

        self.player.world.hitboxes = {}
        local swoopAttackBox = Hitbox {
            world = self.player.world,
            x = self.player.x + 13,
            y = self.player.y,
            xUpdate = 13,
            yUpdate = 0,
            width = 13,
            height = 34,
            type = SWOOP_ATTACK_DAMAGE
        }
        table.insert(self.player.world.hitboxes, swoopAttackBox)

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

function PlayerSwoopAttackState:exit()
    self.player.offsetX = 0
    self.player.offsetY = 0
    self.player.up = false
    self.player.world.hitboxes = {}
end