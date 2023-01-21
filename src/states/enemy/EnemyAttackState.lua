--[[
    EnemyAttackState
]]

EnemyAttackState = Class{__includes = BaseState}

function EnemyAttackState:enter(enemy)
    self.enemy = enemy

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_attack_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_attack_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_attack_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_attack']
    self.attackAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_attack'])
    self.enemy.animation = self.attackAnimation
    self.enemy.animation:refresh()

    self.enemy.dx = 0
    self.hit = false
end

function EnemyAttackState:update(dt)
    
    if self.enemy.animation.currentFrame == gAttackFrame[tostring(self.enemy.type)] and not self.hit 
        and not self.enemy.world.player.invulnerable then

        local heightDifference = (self.enemy.world.player.y + self.enemy.world.player.height) - (self.enemy.y + self.enemy.height)
        local enemyHeight = self.enemy.x + self.enemy.offsetY

        if self.enemy.direction == 'left' and math.abs(heightDifference) < enemyHeight and
            math.abs((self.enemy.x - (self.enemy.world.player.x + self.enemy.world.player.width))) < 3 then

            gSounds['damage']:stop()
            gSounds['damage']:play()
            self.hit = true
            self.enemy.world.player:damage(gDamageAmount[tostring(self.enemy.type) .. '_attack'], 'armor')
            self.enemy.world.player:goInvulnerable(1.5)

            if not self.enemy.world.player.knocked and
                math.random(gKnockChance[tostring(self.enemy.type)]) == 1 then

                self.enemy.world.player.dx = -KNOCK_VELOCITY
                self.enemy.world.player.direction = 'right'
                self.enemy.world.player.state:change('knock_down', self.enemy.world.player)
            end
        
        elseif self.enemy.direction == 'right' and math.abs(heightDifference) < enemyHeight and
            math.abs((self.enemy.world.player.x - (self.enemy.x + self.enemy.width))) < 3 then

            gSounds['damage']:stop()
            gSounds['damage']:play()
            self.hit = true
            self.enemy.world.player:damage(gDamageAmount[tostring(self.enemy.type) .. '_attack'], 'armor')
            self.enemy.world.player:goInvulnerable(1.5)

            if not self.enemy.world.player.knocked and
                math.random(gKnockChance[tostring(self.enemy.type)]) == 1 then

                self.enemy.world.player.dx = KNOCK_VELOCITY
                self.enemy.world.player.direction = 'left'
                self.enemy.world.player.state:change('knock_down', self.enemy.world.player)
            end
        end

    end

    if self.enemy.animation.timesPlayed > 0 then
        self.enemy.state:change('idle', self.enemy)
    end

    self.enemy:checkArrows()
    self.enemy:checkFireballs()
    self.enemy:checkHits()
    
end