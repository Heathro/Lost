--[[
    World
]]

World = Class {}

function World:init(def)
    self.worldWidth = def.worldWidth
    self.worldHeight = def.worldHeight
    self.worldWidthPixels = self.worldWidth * TILE_SIZE
    self.worldHeightPixels = self.worldHeight * TILE_SIZE    

    self.thornSet = def.thornSet
    self.tileSet = def.tileSet
    self.grassSet = def.grassSet
    self.decoreSet = def.decoreSet
    self.wallSet = def.wallSet
    self.hookSet = def.hookSet
    self.textures = def.textures
    self.tileQuads = def.tileQuads    
    
    self.camX = 0
    self.camY = 0
    self.gravity = GRAVITY
    self.deceleration = DECELERATION

    self.tiles = {}
    self.thorns = {}
    self.grass = {}
    self.decore = {}
    self.walls = {}
    local z = 1
    for y = 1, self.worldHeight do
        for x = 1, self.worldWidth do
            self:setTile(x, y, self.tileSet[z])
            self:setThorn(x, y, self.thornSet[z])
            self:setGrass(x, y, self.grassSet[z])
            self:setDecore(x, y, self.decoreSet[z])
            self:setWall(x, y, self.wallSet[z])
            z = z + 1
        end
    end

    self.playerHealth = def.playerHealth
    self.playerMana = def.playerMana
    self.playerArmor = def.playerArmor
    self.playerAgility = def.playerAgility
    self.playerStrength = def.playerStrength
    self.playerArrows = def.playerArrows

    self.playerX = def.playerX
    self.playerY = def.playerY
    self.player = Player(self)
    self.player.state:change('idle', self.player)

    self.objects = def.objects
    for o, object in ipairs(self.objects) do
        object.hidden = false
    end

    self.enemies = def.enemies
    for e, enemy in ipairs(self.enemies) do
        enemy:restore(self)        
    end

    self.portalStartX = def.portalStartX
    self.portalStartY = def.portalStartY
    self.portalFinishX = def.portalFinishX
    self.portalFinishY = def.portalFinishY
    self.portalColor = def.portalColor
    self.portal = Portal(self)
    self.portal.state:change('open', self.portal)

    self.arrows = {}
    self.hitboxes = {}
    self.fireballs = {}
end

function World:update(dt)    
    self.player:update(dt)
    self.portal:update(dt)

    for o, object in pairs(self.objects) do
        if not object.hidden then
            object:update(dt)
        end
    end    

    for a, arrow in pairs(self.arrows) do
        arrow:update(dt)
        if self:collides(self:tileAt(arrow.x + (arrow.width / 2), arrow.y)) or
            arrow.x < self.camX - arrow.width or 
            arrow.x > self.camX + VIRTUAL_WIDTH  then

            arrow.dx = 0
            table.remove(self.arrows, a)
        end
    end

    for h, hitbox in pairs(self.hitboxes) do
        hitbox:update(dt)
    end

    for f, fireball in pairs(self.fireballs) do
        fireball:update(dt)
        if self:collides(self:tileAt(fireball.x + (fireball.width / 2), fireball.y)) or
            self:collides(self:tileAt(fireball.x + (fireball.width / 2), fireball.y + fireball.height - 1)) or
            fireball.x < self.camX - fireball.width or 
            fireball.x > self.camX + VIRTUAL_WIDTH  then

            self.dx = 0
            table.remove(self.fireballs, f)
        end
    end

    for e, enemy in pairs(self.enemies) do
        if not enemy.dead then
            enemy:update(dt)
        end
    end

    self.camX = math.floor(
            math.max(0,
                math.min(self.player.x - VIRTUAL_WIDTH / 2 + self.player.width * 2, 
                    math.min(self.worldWidthPixels - VIRTUAL_WIDTH, self.player.x))))
end

function World:render()
    for y = 1, self.worldHeight do
        for x = 1, self.worldWidth do
            local tile = self:getTile(x, y)
            local thorn = self:getThorn(x, y)
            local grass = self:getGrass(x, y)
            local decore = self:getDecore(x, y)
            local wall = self:getWall(x, y)
            if wall ~= 0 then
                love.graphics.draw(self.textures, self.tileQuads[wall],
                    (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
            if decore ~= 0 then
                love.graphics.draw(self.textures, self.tileQuads[decore],
                    (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
            if grass ~= 0 then
                love.graphics.draw(self.textures, self.tileQuads[grass],
                    (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
            if tile ~= 0 then
                love.graphics.draw(self.textures, self.tileQuads[tile],
                    (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
            if thorn ~= 0 then
                love.graphics.draw(self.textures, self.tileQuads[thorn],
                    (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
            end
        end
    end

    for o, object in pairs(self.objects) do
        if not object.hidden then
            object:render()
        end
    end

    for a, arrow in pairs(self.arrows) do
        arrow:render()
    end

    for f, fireball in pairs(self.fireballs) do
        fireball:render()
    end

    for e, enemy in pairs(self.enemies) do
        if not enemy.dead then
            enemy:render()
        end
    end
end

function World:collides(tile)
    if tile.id == nil then
        return false
    elseif tile.id ~= EMPTY_TILE then
        return true
    end
    return false
end

function World:hooks(tile)
    for h, hook in ipairs(self.hookSet) do
        if tile.id == hook then
            return true
        end
    end
    return false
end

-- tiles
function World:tileAt(x, y)
    return {
        x = math.floor(x / TILE_SIZE) + 1,
        y = math.floor(y / TILE_SIZE) + 1,
        id = self:getTile(math.floor(x / TILE_SIZE) + 1, math.floor(y / TILE_SIZE) + 1)
    }
end

function World:setTile(x, y, id)
    self.tiles[(y - 1) * self.worldWidth + x] = id
end

function World:getTile(x, y)
    return self.tiles[(y - 1) * self.worldWidth + x]
end

-- thorns
function World:thornAt(x, y)
    return {
        x = math.floor(x / TILE_SIZE) + 1,
        y = math.floor(y / TILE_SIZE) + 1,
        id = self:getThorn(math.floor(x / TILE_SIZE) + 1, math.floor(y / TILE_SIZE) + 1)
    }
end

function World:setThorn(x, y, id)
    self.thorns[(y - 1) * self.worldWidth + x] = id
end

function World:getThorn(x, y)
    return self.thorns[(y - 1) * self.worldWidth + x]
end

-- grass
function World:setGrass(x, y, id)
    self.grass[(y - 1) * self.worldWidth + x] = id
end

function World:getGrass(x, y)
    return self.grass[(y - 1) * self.worldWidth + x]
end

-- decore
function World:setDecore(x, y, id)
    self.decore[(y - 1) * self.worldWidth + x] = id
end

function World:getDecore(x, y)
    return self.decore[(y - 1) * self.worldWidth + x]
end

-- walls
function World:setWall(x, y, id)
    self.walls[(y - 1) * self.worldWidth + x] = id
end

function World:getWall(x, y)
    return self.walls[(y - 1) * self.worldWidth + x]
end