--[[
    PlayerAttackJumpState
]]

PlayerAttackJumpState = Class{__includes = BaseState}

function PlayerAttackJumpState:enter(player)
    self.player = player

    self.player.up = true

    self.player.offsetX = self.player.direction == 'left' and -1 or 1
    self.player.offsetY = 1

    self.player.texture = gTextures['attack_jump']
    self.attackJumpAnimation = Animation(gPlayerAnimations['attack_jump'])
    self.player.animation = self.attackJumpAnimation
    self.player.animation:refresh()
end

function PlayerAttackJumpState:update(dt)

    if self.player.direction == 'left' then
        self.player.offsetX = -1

        if self.player.animation.currentFrame == 1 then

            gSounds['attack_air']:stop()
            gSounds['attack_air']:play()
            
            local attackJumpBox = Hitbox {
                world = self.player.world,
                x = self.player.x - 15,
                y = self.player.y + 5,
                xUpdate = -15,
                yUpdate = 1,
                width = 15,
                height = 27,
                type = ATTACK_JUMP_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackJumpBox)

        else
            self.player.world.hitboxes = {}

        end

    elseif self.player.direction == 'right' then
        self.player.offsetX = 1

        if self.player.animation.currentFrame == 1 then

            gSounds['attack_air']:stop()
            gSounds['attack_air']:play()

            local attackJumpBox = Hitbox {
                world = self.player.world,
                x = self.player.x + self.player.width,
                y = self.player.y + 5,
                xUpdate = self.player.width,
                yUpdate = 1,
                width = 15,
                height = 27,
                type = ATTACK_JUMP_DAMAGE
            }
            table.insert(self.player.world.hitboxes, attackJumpBox)

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
   
    if self.player.animation.timesPlayed > 0 and self.player.dy > 0 then
        self.player.state:change('fall', self.player)
    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()    
    self.player:checkJumpingCollision()
    self.player:checkHookCollision()
    self.player:checkSideCollision()

end

function PlayerAttackJumpState:exit()
    self.player.world.hitboxes = {}
    self.player.up = false
    self.player.offsetX = 0
    self.player.offsetY = 0
end