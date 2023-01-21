--[[
    PortalOpeningState
]]

PortalOpeningState = Class{__includes = BaseState}

function PortalOpeningState:enter(portal)
    self.portal = portal
    self.portal.exist = true
    
    self.portal.texture = gTextures['opening_' .. tostring(self.portal.portalColor)]
    self.openingAnimation = Animation(gPortalAnimations['opening_' .. tostring(self.portal.portalColor)])
    self.portal.animation = self.openingAnimation
    self.portal.animation:refresh()
end

function PortalOpeningState:update(dt)
    if self.portal.animation.timesPlayed > 0 then
        self.portal.animation.timesPlayed = 0
        self.portal.state:change('open', self.portal)
    end
end