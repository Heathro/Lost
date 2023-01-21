--[[
    PlayState
]]

PlayState = Class{__includes = BaseState}

function PlayState:init(params)
    self.dataSet = gLevel['level_' .. tostring(LEVEL)]

    self.world = World {
        playerHealth = params.playerHealth,
        playerMana = params.playerMana,
        playerArmor = params.playerArmor,
        playerAgility = params.playerAgility,
        playerStrength = params.playerStrength,
        playerArrows = params.playerArrows,
        
        tileSet = self.dataSet.tileSet,
        thornSet = self.dataSet.thornSet,
        grassSet = self.dataSet.grassSet,
        decoreSet = self.dataSet.decoreSet,
        wallSet = self.dataSet.wallSet,
        hookSet = self.dataSet.hookSet,
        textures = self.dataSet.textures,
        tileQuads = self.dataSet.tileQuads,

        worldWidth = self.dataSet.worldWidth,
        worldHeight = self.dataSet.worldHeight,

        playerX = self.dataSet.playerX,
        playerY = self.dataSet.playerY,

        portalStartX = self.dataSet.portalStartX,
        portalStartY = self.dataSet.portalStartY,        
        portalFinishX = self.dataSet.portalFinishX,
        portalFinishY = self.dataSet.portalFinishY,
        portalColor = self.dataSet.portalColor,

        objects = self.dataSet.objects,
        enemies = self.dataSet.enemies
    }

    if LEVEL == 7 or LEVEL == 8 then
        self.water = Water()
    end

    gSounds['menu']:stop()
    gSounds['level_' .. (tostring(LEVEL))]:setLooping(true)
    gSounds['level_' .. (tostring(LEVEL))]:setVolume(0.1)
    gSounds['level_' .. (tostring(LEVEL))]:play()
end

function PlayState:update(dt)
    BACKGROUND1_SCROLL = math.floor(self.world.camX / 8 + 0.5)
    BACKGROUND2_SCROLL = math.floor(self.world.camX / 6 + 0.5)
    BACKGROUND3_SCROLL = math.floor(self.world.camX / 4 + 0.5)
    BACKGROUND4_SCROLL = math.floor(self.world.camX / 2 + 0.5)
    FOREGROUND_SCROLL = math.floor(self.world.camX / 2 + 0.5)
    
    self.world:update(dt)

    if self.water ~= nil then
        self.water:update(dt)  
    end

    EVENT_HANDLER:update(self.world.camX)

    if love.keyboard.wasPressed(PAUSE) then
        gStateStack:push(PauseState(self.world.camX))
    end
end

function PlayState:render()
    love.graphics.draw(self.dataSet.background1, -BACKGROUND1_SCROLL, 0)
    love.graphics.draw(self.dataSet.background2, -BACKGROUND2_SCROLL, 0)
    love.graphics.draw(self.dataSet.background3, -BACKGROUND3_SCROLL, 0)
    love.graphics.draw(self.dataSet.background4, -BACKGROUND4_SCROLL, 0)
    love.graphics.translate(math.floor(-self.world.camX + 0.5), math.floor(-self.world.camY + 0.5))

    if LEVEL % 2 == 0 then
        local lightX = (self.world.player.x + self.world.player.width / 2) - self.world.camX
        local lightY = self.world.player.y + self.world.player.height / 2        
        love.graphics.setShader(gShaders['light'])
        gShaders['light']:send("screen", {VIRTUAL_WIDTH, VIRTUAL_HEIGHT})
        gShaders['light']:send("num_lights", 1)
        gShaders['light']:send("lights[0].position", {lightX, lightY})
        gShaders['light']:send("lights[0].diffuse", {1, 1, 0.7})
        gShaders['light']:send("lights[0].power", self.world.player.lightPower)

        if self.world.portal.exist and #self.world.fireballs > 0 then
            local portalX = (self.world.portal.x + self.world.portal.width / 2) - self.world.camX
            local portalY = self.world.portal.y + self.world.portal.height / 2
            gShaders['light']:send("num_lights", #self.world.fireballs + 2)
            gShaders['light']:send("lights[1].position", {portalX, portalY})
            gShaders['light']:send("lights[1].diffuse", {1, 0, 1})
            gShaders['light']:send("lights[1].power", 64)
            for f, fireball in pairs(self.world.fireballs) do
                gShaders['light']:send("lights["..tostring(f+1).."].position", {
                    (fireball.x + fireball.width / 2) - self.world.camX, 
                    fireball.y + fireball.height / 2
                })
                gShaders['light']:send("lights["..tostring(f+1).."].diffuse", {1, 111/255, 30/255})
                gShaders['light']:send("lights["..tostring(f+1).."].power", 80)
            end
        
        elseif self.world.portal.exist and #self.world.fireballs == 0 then
            local portalX = (self.world.portal.x + self.world.portal.width / 2) - self.world.camX
            local portalY = self.world.portal.y + self.world.portal.height / 2
            gShaders['light']:send("num_lights", 2)
            gShaders['light']:send("lights[1].position", {portalX, portalY})
            gShaders['light']:send("lights[1].diffuse", {1, 0, 1})
            gShaders['light']:send("lights[1].power", 64)

        elseif not self.world.portal.exist and #self.world.fireballs > 0 then
            gShaders['light']:send("num_lights", #self.world.fireballs + 1)
            for f, fireball in pairs(self.world.fireballs) do
                gShaders['light']:send("lights["..tostring(f).."].position", {
                    (fireball.x + fireball.width / 2) - self.world.camX, 
                    fireball.y + fireball.height / 2
                })
                gShaders['light']:send("lights["..tostring(f).."].diffuse", {1, 111/255, 30/255})
                gShaders['light']:send("lights["..tostring(f).."].power", 80)
            end

        end

        self.world:render()
        love.graphics.setShader()
    else
        self.world:render()
    end

    self.world.player:render()
    self.world.portal:render()

    if LEVEL % 2 == 0 then
        love.graphics.setColor(0.3, 0.3, 0.3, 1)
    end
    love.graphics.draw(self.dataSet.foreground, -FOREGROUND_SCROLL, 0)

    if self.water ~= nil then
        self.water:render()
    end

    self.world.player.gameplayUI:render()

    --DisplayData(self.world)
    --DebugFrame(self.world)
end

function PlayState:exit()
    gSounds['level_' .. (tostring(LEVEL))]:stop()
    gSounds['menu']:play()
end