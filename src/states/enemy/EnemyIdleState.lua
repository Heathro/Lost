--[[
    EnemyIdleState
]]

EnemyIdleState = Class{__includes = BaseState}

function EnemyIdleState:enter(enemy)
    self.enemy = enemy

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_idle_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_idle_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_idle_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_idle']
    self.idleAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_idle'])
    self.enemy.animation = self.idleAnimation
    self.enemy.animation:refresh()

    self.waitDuration = 0
    self.waitTimer = 0

    self.enemy.dx = 0
end

function EnemyIdleState:update(dt)

    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)

    else
        self.waitTimer = self.waitTimer + dt
        if self.waitTimer > self.waitDuration then

            if self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x - 1, self.enemy.y)) or
                self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x - 1, self.enemy.y + self.enemy.height - 1)) or
                self.enemy.world:tileAt(self.enemy.x - 1, self.enemy.y).x <= 0 or
                not self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x - 1, self.enemy.y + self.enemy.height + 1)) then

                self.enemy.direction = 'right'
                self.enemy.dx = self.enemy.moveSpeed

            elseif self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x + self.enemy.width, self.enemy.y)) or
                self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x + self.enemy.width, self.enemy.y + self.enemy.height - 1)) or
                self.enemy.world:tileAt(self.enemy.x + self.enemy.width, self.enemy.y).x > self.enemy.world.worldWidth or
                not self.enemy.world:collides(self.enemy.world:tileAt(self.enemy.x + self.enemy.width, self.enemy.y + self.enemy.height + 1)) then

                self.enemy.direction = 'left'
                self.enemy.dx = -self.enemy.moveSpeed

            else
                if math.random(2) == 1 then
                    self.enemy.direction = 'left'
                    self.enemy.dx = -self.enemy.moveSpeed
                else
                    self.enemy.direction = 'right'
                    self.enemy.dx = self.enemy.moveSpeed
                end
            end

            self.enemy.state:change('move', self.enemy)

        end
    end

    self.enemy:checkArrows()
    self.enemy:checkFireballs()
    self.enemy:checkHits()
    self.enemy:checkPlayer()    

end