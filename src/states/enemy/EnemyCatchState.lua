--[[
    EnemyCatchState
]]

EnemyCatchState = Class{__includes = BaseState}

function EnemyCatchState:enter(enemy)
    self.enemy = enemy

    self.enemy.offsetX = self.enemy.direction == 'left' and 
                         gEnemyOffsets[tostring(self.enemy.type) .. '_move_x'] or
                         -gEnemyOffsets[tostring(self.enemy.type) .. '_move_x']
    self.enemy.offsetY = gEnemyOffsets[tostring(self.enemy.type) .. '_move_y']
    
    self.enemy.texture = gTextures[tostring(self.enemy.type) .. '_move']
    self.catchAnimation = Animation(gEnemyAnimations[tostring(self.enemy.type) .. '_move'])
    self.enemy.animation = self.catchAnimation
    self.enemy.animation:refresh()
end

function EnemyCatchState:update(dt)    

    if ((self.enemy.world.player.y + self.enemy.world.player.height) ~= (self.enemy.y + self.enemy.height) and
        not self.enemy.world.player.up) or self.enemy.world.player.invisible or
        math.abs(self.enemy.world.player.x - self.enemy.x) > TILE_SIZE * 10 or 
        self.enemy:checkObstruction() or self.enemy.world.player.knocked 
        or self.enemy.world.player.dead then
            
        self.enemy.state:change('idle', self.enemy)
    end

    if self.enemy.world.player.x + self.enemy.world.player.width < self.enemy.x then
        self.enemy.direction = 'left'
        self.enemy.dx = -self.enemy.catchSpeed

        if math.abs((self.enemy.world.player.y + self.enemy.world.player.height) - (self.enemy.y + self.enemy.height)) < TILE_SIZE / 4 and
            (self.enemy.x - (self.enemy.world.player.x + self.enemy.world.player.width)) < 2 then

            self.enemy.state:change('attack', self.enemy)
        end

    elseif self.enemy.world.player.x > self.enemy.x + self.enemy.width then
        self.enemy.direction = 'right'
        self.enemy.dx = self.enemy.catchSpeed

        if math.abs((self.enemy.world.player.y + self.enemy.world.player.height) - (self.enemy.y + self.enemy.height)) < TILE_SIZE / 4 and
            (self.enemy.world.player.x - (self.enemy.x + self.enemy.width)) < 2 then

            self.enemy.state:change('attack', self.enemy)
        end
    end
    
    self.enemy.x = self.enemy.x + self.enemy.dx * dt

    self.enemy:checkArrows()
    self.enemy:checkFireballs()
    self.enemy:checkHits()
    self.enemy:checkSides()

end