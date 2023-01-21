--[[
    PortalClosedState
]]

PortalClosedState = Class{__includes = BaseState}

function PortalClosedState:enter(portal)
    self.portal = portal
    self.portal.exist = false

    self.portal.texture = gTextures['closed']
    self.closedAnimation = Animation(gPortalAnimations['closed'])
    self.portal.animation = self.closedAnimation
    self.portal.animation:refresh()
end

function PortalClosedState:update(dt)
    if self.portal.world.player.x > self.portal.world.worldWidthPixels - TILE_SIZE * 18
        and not self.portal.open then

        self.portal.open = true
        self.portal.x = self.portal.portalFinishX
        self.portal.y = self.portal.portalFinishY
        self.portal.direction = 'left'
        self.portal.state:change('opening', self.portal)
    end
end