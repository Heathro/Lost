--[[
    PlayerPullUpState
]]

PlayerPullUpState = Class{__includes = BaseState}

function PlayerPullUpState:enter(player)
    self.player = player

    self.player.texture = gTextures['pull_up']
    self.pullAnimation = Animation(gPlayerAnimations['pull_up'])
    self.player.animation = self.pullAnimation
    self.player.animation:refresh()

    if self.player.direction == 'right' then

        local newX = (self.player.world:tileAt(self.player.x + self.player.width, self.player.y).x - 1) * TILE_SIZE - self.player.width + 6
        local newY = (self.player.world:tileAt(self.player.x + self.player.width, self.player.y).y) * TILE_SIZE - TILE_SIZE - self.player.height
            
        Timer.tween(0.25, {
            [self.player] = { y = newY }
        }):finish(function()
            Timer.tween(0.1, {
                [self.player] = { x = newX }
            }):finish(function()
                self.player.state:change('sit', self.player)
            end)
        end)

    elseif self.player.direction == 'left' then

        local newX = self.player.world:tileAt(self.player.x - 1, self.player.y).x * TILE_SIZE - 6
        local newY = (self.player.world:tileAt(self.player.x - 1, self.player.y).y) * TILE_SIZE - TILE_SIZE - self.player.height

        Timer.tween(0.25, {
            [self.player] = { y = newY }
        }):finish(function()
            Timer.tween(0.1, {
                [self.player] = { x = newX }
            }):finish(function()
                self.player.state:change('sit', self.player)
            end)
        end)
    end

    self.player:checkEnemyCollision()
    self.player:checkObjectCollision()
    self.player:checkThornCollision()

    gSounds['pull']:play()
end