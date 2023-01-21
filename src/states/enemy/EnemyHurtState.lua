--[[
    EnemyHurtState
]]

EnemyHurtState = Class{__includes = BaseState}

function EnemyHurtState:enter(enemy)
    self.enemy = enemy

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_hurt_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_hurt_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_hurt_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_hurt']
    self.hurtAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_hurt'])
    self.enemy.animation = self.hurtAnimation
    self.enemy.animation:refresh()

    self.enemy.dx = 0
end

function EnemyHurtState:update(dt)

    if self.enemy.animation.timesPlayed > 0 then
        self.enemy.state:change('idle', self.enemy)
    end

end