--[[
    Helper
]]

function GenerateQuads(atlas, tileWidth, tileHeight)    
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[sheetCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight,
                tileWidth, tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end

function DisplayData(world)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(gFonts['small'])

    love.graphics.printf(tostring(love.timer.getFPS()) .. ' FPS', world.camX - 5, 91, VIRTUAL_WIDTH, 'right')
    love.graphics.printf(tostring(LIVES) .. ' LIVES', world.camX - 5, 98, VIRTUAL_WIDTH, 'right')
    love.graphics.printf(tostring(LEVEL) .. ' LEVEL', world.camX - 5, 105, VIRTUAL_WIDTH, 'right')

    love.graphics.printf(tostring(world.player.state:getName()) .. ' STATE', world.camX - 5, 112, VIRTUAL_WIDTH, 'right')

    love.graphics.printf(tostring(math.floor(world.player.x / TILE_SIZE) + 1) .. ' X',
                            world.camX - 5, 119, VIRTUAL_WIDTH, 'right')
    love.graphics.printf(tostring(math.floor(world.player.y / TILE_SIZE) + 2) .. ' Y',
                            world.camX - 5, 126, VIRTUAL_WIDTH, 'right')

    love.graphics.setColor(1, 1, 1, 1)
end

function DebugFrame(world)
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.rectangle('line', math.floor(world.player.x), math.floor(world.player.y), 
                            math.floor(world.player.width), math.floor(world.player.height))
    love.graphics.rectangle('line', math.floor(world.portal.x), math.floor(world.portal.y), 
                            math.floor(world.portal.width), math.floor(world.portal.height))
    for e, enemy in pairs(world.enemies) do
        love.graphics.rectangle('line', math.floor(enemy.x), math.floor(enemy.y), 
                            math.floor(enemy.width), math.floor(enemy.height))
    end    
    for o, object in pairs(world.objects) do
        love.graphics.rectangle('line', math.floor(object.x), math.floor(object.y), 
                            math.floor(object.width), math.floor(object.height))
    end 
    for a, arrow in pairs(world.arrows) do
        love.graphics.rectangle('line', math.floor(arrow.x), math.floor(arrow.y), 
                            math.floor(arrow.width), math.floor(arrow.height))
    end 
    for a, hitbox in pairs(world.hitboxes) do
        love.graphics.rectangle('line', math.floor(hitbox.x), math.floor(hitbox.y), 
                            math.floor(hitbox.width), math.floor(hitbox.height))
    end 
    for f, fireball in pairs(world.fireballs) do
        love.graphics.rectangle('line', math.floor(fireball.x), math.floor(fireball.y), 
                            math.floor(fireball.width), math.floor(fireball.height))
    end 
    love.graphics.setColor(1, 1, 1, 1)  
end