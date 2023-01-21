--[[
    Portal
]]

Portal = Class {}

function Portal:init(world)
    self.world = world

    self.width = 64
    self.height = 64

    self.portalStartX = self.world.portalStartX * TILE_SIZE - TILE_SIZE * 2
    self.portalStartY = self.world.portalStartY * TILE_SIZE - TILE_SIZE * 4 + 4
    self.portalFinishX = self.world.portalFinishX * TILE_SIZE - TILE_SIZE * 2
    self.portalFinishY = self.world.portalFinishY * TILE_SIZE - TILE_SIZE * 4 + 4
    self.portalColor = self.world.portalColor
    
    self.x = self.portalStartX
    self.y = self.portalStartY
    self.direction = 'right'
    self.open = false

    self.exist = true

    self.texture = gTextures['open_' .. tostring(self.portalColor)]
    self.animation = Animation(gPortalAnimations['open_'.. tostring(self.portalColor)])
   
    self.state = StateMachine {        
        ['closed'] = function() return PortalClosedState() end,
        ['opening'] = function() return PortalOpeningState() end,
        ['closing'] = function() return PortalClosingState() end,
        ['open'] = function() return PortalOpenState() end
    }
end

function Portal:update(dt)
    self.animation:update(dt)
    self.state:update(dt)
end

function Portal:render()
    if self.exist then
        love.graphics.draw(self.texture, 
        gObjects[self.animation.texture][self.animation:getCurrentFrame()],
        math.floor(self.x + self.width / 2),
        math.floor(self.y + self.height / 2),
        0, 
        self.direction == 'right' and 1 or -1,
        1,
        self.width / 2, self.height / 2)
    end
end

function Portal:collides(player)
    return not (self.x + 25 > player.x + player.width or player.x > self.x + self.width - 25 or
        self.y + 15 > player.y + player.height or player.y > self.y + self.height - 15)
end