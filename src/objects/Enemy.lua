--[[
    Enemy
]]

Enemy = Class {}

function Enemy:init(def)
    self.world = nil
    self.type = def.type
    
    self.width = gEnemySizes[tostring(self.type) .. '_width']
    self.height = gEnemySizes[tostring(self.type) .. '_height']
    self.health = gEnemyHealth[tostring(self.type) .. '_health']
    self.maxHealth = gEnemyHealth[tostring(self.type) .. '_maxHealth']
    self.moveSpeed = gEnemySpeed[tostring(self.type) .. '_move']
    self.catchSpeed = gEnemySpeed[tostring(self.type) .. '_catch']
    
    self.x = def.x * TILE_SIZE - TILE_SIZE
    self.y = def.y * TILE_SIZE - self.height
    self.spawnX = self.x
    self.spawnY = self.y

    self.offsetX = 0
    self.offsetY = 0    
    self.dx = 0
    self.dy = 0
    self.death = false
    self.dead = false

    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0

    self.cursed = false
    self.curse = nil
    self.cursedDuration = 0
    self.cursedTimer = 0
    
    self.texture = gTextures[tostring(self.type) .. '_idle']
    self.direction = 'left'
    self.animation = Animation(gEnemyAnimations[tostring(self.type) .. '_idle'])
    self.state = StateMachine {
        ['idle'] = function() return EnemyIdleState() end,
        ['move'] = function() return EnemyMoveState() end,
        ['hurt'] = function() return EnemyHurtState() end,
        ['die'] = function() return EnemyDieState() end,
        ['catch'] = function() return EnemyCatchState() end,
        ['attack'] = function() return EnemyAttackState() end
    }
    self.state:change('idle', self)
end

function Enemy:update(dt)
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt
        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end

    if self.cursed then
        self.cursedTimer = self.cursedTimer + dt
        if self.cursedTimer > self.cursedDuration then
            self.cursed = false
            self.cursedTimer = 0
            self.cursedDuration = 0
        end
    end

    self.animation:update(dt)
    self.state:update(dt)
end

function Enemy:render()
    love.graphics.setColor(1, 1, 1, 1)

    if not self.death then
        if self.cursed then
            love.graphics.setShader(gShaders['curse'])
            gShaders['curse']:send("BlackFactor", 0.7)
        end
        if self.invulnerable and self.flashTimer > 0.06 then
            self.flashTimer = 0
            love.graphics.setShader(gShaders['invulnerable_enemy'])
            gShaders['invulnerable_enemy']:send("RedFactor", 1.0)
        end
    end

    love.graphics.draw(self.texture,
        gEnemies[self.animation.texture][self.animation:getCurrentFrame()], 
        math.floor(self.x + self.width / 2 - self.offsetX),
        math.floor(self.y + self.height / 2 - self.offsetY),
        0, 
        self.direction == 'left' and 1 or -1,
        1,
        self.width / 2, self.height / 2)
            
    love.graphics.setColor(1, 1, 1, 1)

    if LEVEL % 2 == 0 then
        love.graphics.setShader(gShaders['light'])
    else
        love.graphics.setShader()
    end
end

function Enemy:damage(damage)        
    self.health = self.health - damage

    local popup = Popup {
        player = self, x = self.x + self.width / 3, y = self.y - 5,
        color = {r = 1, g = 0, b = 0}, value = '-'..damage
    }
    table.insert(self.world.player.gameplayUI.popups, popup)
    Timer.tween(1, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.world.player.gameplayUI.popups, 1)
    end)

    if self.health <= 0 then
        self.state:change('die', self)
    else
        self.state:change('hurt', self)
    end
end

function Enemy:collides(player)
    return not (player.x > self.x + self.width or self.x > player.x + player.width or
            player.y > self.y + self.height or self.y > player.y + player.height)
end

function Enemy:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Enemy:getCurse(duration)
    self.cursedDuration = duration
    self.cursed = true
    self.curse = Timer.every(CURSE_INTERVAL_ENEMY, function () 
        if not self.dead then
            self:damage(CURSE_DAMAGE_ENEMY)
        end
    end):limit(CURSE_DURATION_ENEMY)
end

function Enemy:checkArrows()
    for a, arrow in pairs(self.world.arrows) do
        if arrow:collides(self) then
            if not self.invulnerable then
                
                if self.health > ARROW_DAMAGE then
                    gSounds[tostring(self.type) .. '_damage']:play()
                else
                    gSounds[tostring(self.type) .. '_death']:play()
                end

                self:damage(ARROW_DAMAGE)
                self:goInvulnerable(1.5)
                table.remove(self.world.arrows, a)
            end
        end
    end
end

function Enemy:checkFireballs()
    for f, fireball in pairs(self.world.fireballs) do
        if fireball:collides(self) then
            if not self.invulnerable then

                if self.health > FIREBALL_DAMAGE then
                    gSounds[tostring(self.type) .. '_damage']:play()
                else
                    gSounds[tostring(self.type) .. '_death']:play()
                end
                
                self:damage(FIREBALL_DAMAGE)
                self:goInvulnerable(1.5)
                table.remove(self.world.fireballs, f)                
            end
        end
    end
end

function Enemy:checkHits()
    for h, hitbox in pairs(self.world.hitboxes) do
        if hitbox:collides(self) then
            if not self.invulnerable then

                if self.health > hitbox.type then
                    gSounds[tostring(self.type) .. '_damage']:play()
                else
                    gSounds[tostring(self.type) .. '_death']:play()
                end

                self:damage(hitbox.type)
                self:goInvulnerable(1.5)
            end
        end
    end
end

function Enemy:checkSides()
    if self.dx < 0 then
        if self.world:collides(self.world:tileAt(self.x - 1, self.y)) or
            self.world:collides(self.world:tileAt(self.x - 1, self.y + self.height - 1)) or
            self.world:tileAt(self.x - 1, self.y).x <= 0 or
            not self.world:collides(self.world:tileAt(self.x - 1, self.y + self.height + 1)) then
            
            self.dx = 0
            self.x = self.world:tileAt(self.x - 1, self.y).x * TILE_SIZE
            self.state:change('idle', self)
        end
    elseif self.dx > 0 then
        if self.world:collides(self.world:tileAt(self.x + self.width, self.y)) or
            self.world:collides(self.world:tileAt(self.x + self.width, self.y + self.height - 1)) or
            self.world:tileAt(self.x + self.width, self.y).x > self.world.worldWidth or
            not self.world:collides(self.world:tileAt(self.x + self.width, self.y + self.height + 1)) then
            
            self.dx = 0
            self.x = (self.world:tileAt(self.x + self.width, self.y).x - 1) * TILE_SIZE - self.width
            self.state:change('idle', self)
        end
    end
end

function Enemy:checkPlayer()
    if not self.world.player.invisible and not self.world.player.knocked then
        if (self.world.player.y + self.world.player.height) == (self.y + self.height) and
            math.abs((self.world.player.x + self.world.player.width / 2) - (self.x + self.width / 2)) < TILE_SIZE * 8 and
            not self:checkObstruction() and not self.world.player.dead then

            gSounds[tostring(self.type) .. '_catch']:play()

            if self.world.player.x + self.world.player.width / 2 < self.x + self.width / 2 then

                self.direction = 'left'
                self.dx = -self.catchSpeed
                self.state:change('catch', self)

            elseif self.world.player.x + self.world.player.width / 2 > self.x + self.width / 2 then

                self.direction = 'right'
                self.dx = self.catchSpeed
                self.state:change('catch', self)

            end
        end
    end
end

function Enemy:checkObstruction()
    if self.world.player.x + self.world.player.width / 2 < self.x + self.width / 2 then

        local playerPos = self.world.player.x + self.world.player.width
        local enemyPos = self.x
        local heightPos = self.y + self.height - 1
        for x = playerPos, enemyPos do
            if self.world:collides(self.world:tileAt(x, heightPos)) then
                return true
            elseif not self.world:collides(self.world:tileAt(x, heightPos + TILE_SIZE)) then
                return true
            end
            x = x + TILE_SIZE
        end

    elseif self.world.player.x + self.world.player.width / 2 > self.x + self.width / 2 then

        local playerPos = self.world.player.x
        local enemyPos = self.x + self.width
        local heightPos = self.y + self.height - 1
        for x = enemyPos, playerPos do
            if self.world:collides(self.world:tileAt(x, heightPos)) then
                return true
            elseif not self.world:collides(self.world:tileAt(x, heightPos + TILE_SIZE)) then
                return true
            end
            x = x + TILE_SIZE
        end

    end

    return false
end

function Enemy:restore(world)
    self.world = world
    self.dead = false
    self.death = false
    self.health = self.maxHealth

    self.direction = 'left'
    self.x = self.spawnX
    self.y = self.spawnY
    self.dx = 0
    self.dy = 0

    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0
    self.cursed = false
    if self.curse ~= nil then self.curse:remove() end
    self.cursedDuration = 0
    self.cursedTimer = 0

    self.state:change('idle', self)
end