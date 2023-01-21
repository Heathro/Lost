--[[
    PortalClosingState
]]

PortalClosingState = Class{__includes = BaseState}

function PortalClosingState:enter(portal)
    self.portal = portal
    self.portal.exist = true

    self.portal.texture = gTextures['closing_' .. tostring(self.portal.portalColor)]
    self.closingAnimation = Animation(gPortalAnimations['closing_' .. tostring(self.portal.portalColor)])
    self.portal.animation = self.closingAnimation
    self.portal.animation:refresh()
end

function PortalClosingState:update(dt)
    if self.portal.animation.timesPlayed > 0 then
        self.portal.animation.timesPlayed = 0
        self.portal.state:change('closed', self.portal)
    end
end