--[[
    PlayerAttackFallState
]]

PlayerAttackFallState = Class{__includes = BaseState}

function PlayerAttackFallState:enter(player)
    self.player = player

    self.player.up = true

    self.player.offsetX = self.player.direction == 'left' and -13 or 13
    self.player.offsetY = 1

    self.player.texture = gTextures['attack_fall']
    self.attackFallAnimation = Animation(gPlayerAnimations['attack_fall'])
    self.player.animation = self.attackFallAnimation
    self.player.animation:refresh()
end

function PlayerAttackFallState:update(dt)
    
    if self.player.direction == 'left' then
        self.player.offsetX = -13

        if self.player.animation.currentFrame == 2 then

            gSounds['attack_air']:stop()
            gSounds['attack_air']:play()

            local attackFallBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 15,
                y = self.player.y + 5,
                xUpdate = -15,
                yUpdate = 5,
                width = 15,
                height = 20,
                type = ATTACK_FALL_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackFallBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 13

        if self.player.animation.currentFrame == 2 then

            gSounds['attack_air']:stop()
            gSounds['attack_air']:play()

            local attackFallBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 5,
                width = 15,
                height = 20,
                type = ATTACK_FALL_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackFallBox)

        else
            self.player.world.hitboxes = {}

        end

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
    self.player:checkHookCollision()
    self.player:checkSideCollision()    

end

function PlayerAttackFallState:exit()
    self.player.world.hitboxes = {}
    self.player.offsetX = 0
    self.player.offsetY = 0
    self.player.up = false
end