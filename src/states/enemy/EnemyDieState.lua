--[[
    EnemyDieState
]]

EnemyDieState = Class{__includes = BaseState}

function EnemyDieState:enter(enemy)
    self.enemy = enemy
    self.enemy.death = true

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_die_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_die_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_die_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_die']
    self.dieAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_die'])
    self.enemy.animation = self.dieAnimation
    self.enemy.animation:refresh()

    self.enemy.dx = 0
end

function EnemyDieState:update(dt)

    if self.enemy.animation.timesPlayed > 0 then
        self.enemy.dead = true
    end

end