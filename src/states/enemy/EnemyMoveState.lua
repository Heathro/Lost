--[[
    EnemyMoveState
]]

EnemyMoveState = Class{__includes = BaseState}

function EnemyMoveState:enter(enemy)
    self.enemy = enemy

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_move_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_move_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_move_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_move']
    self.moveAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_move'])
    self.enemy.animation = self.moveAnimation
    self.enemy.animation:refresh()

    self.moveDuration = 0
    self.moveTimer = 0
end

function EnemyMoveState:update(dt)

    if self.moveDuration == 0 then
        self.moveDuration = math.random(5)

    elseif self.moveTimer > self.moveDuration then
        self.moveTimer = 0

        if math.random(5) == 1 then
            self.enemy.state:change('idle', self.enemy)
        else
            self.moveDuration = math.random(5)
        end
    end

    self.enemy.x = self.enemy.x + self.enemy.dx * dt
    self.moveTimer = self.moveTimer + dt

    self.enemy:checkArrows()
    self.enemy:checkFireballs()
    self.enemy:checkHits()
    self.enemy:checkSides()
    self.enemy:checkPlayer()

end