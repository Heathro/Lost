--[[
    Player
]]

Player = Class {}

function Player:init(world)
    self.world = world

    self.width = 20
    self.height = 30
    self.offsetX = 0
    self.offsetY = 0
    self.x = self.world.playerX * TILE_SIZE - TILE_SIZE
    self.y = self.world.playerY * TILE_SIZE - self.height
    self.dx = 0
    self.dy = 0

    self.defaultCrouchSpeed = PLAYER_CROUCH_DEFAULT
    self.defaultWalkSpeed = PLAYER_WALK_DEFAULT
    self.defaultRunSpeed = PLAYER_RUN_DEFAULT
    self.defaultSprintSpeed = PLAYER_SPRINT_DEFAULT

    self.increasedCrouchSpeed = PLAYER_CROUCH_INCREASED
    self.increasedWalkSpeed = PLAYER_WALK_INCREASED
    self.increasedRunSpeed = PLAYER_RUN_INCREASED
    self.increasedSprintSpeed = PLAYER_SPRINT_INCREASED

    self.crouchSpeed = self.defaultCrouchSpeed
    self.walkSpeed = self.defaultWalkSpeed
    self.runSpeed = self.defaultRunSpeed
    self.sprintSpeed = self.defaultSprintSpeed
    self.jumpVelocity = PLAYER_JUMP_VELOCITY
    self.sideVelocity = PLAYER_SIDE_VELOCITY
    self.unhookVelocity = PLAYER_UNHOOK_VELOCITY
    self.preKickVelocity = PLAYER_PRE_KICK_VELOCITY
    self.preAttackVelocity = PLAYER_PRE_ATTACK_VELOCITY

    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0
    self.flashTimer = 0
    self.inviolable = false
    self.inviolableType = gObjectFrame['purple_medium_potion']

    self.accelerated = false
    self.acceleratedDuration = 0
    self.acceleratedTimer = 0
    self.acceleratedType = gObjectFrame['bronze_shoe']
    
    self.enlargedLightPower = LIGHT_ENLARGED
    self.defaultLightPower = LIGHT_NORMAL
    self.lightPower = self.defaultLightPower
    self.enlargeLight = false
    self.enlargeLightDuration = 0
    self.enlargeLightTimer = 0

    self.cursed = false
    self.cursedDuration = 0
    self.cursedTimer = 0

    self.invisible = false
    self.invisibleDuration = 0
    self.invisibleTimer = 0
    self.invisibleType = gObjectFrame['empty_medium_potion']

    self.eating = false
    self.eatingDuration = 0
    self.eatingTimer = 0
    self.eatingType = gObjectFrame['cookie']    
    
    self.dead = false
    self.knocked = false
    self.low = false
    self.up = false
    self.teleports = false

    self.casted = false
    self.launched = false

    self.swordEquiped = false
    self.stance = FIST
    
    self.texture = gTextures['idle']
    self.direction = 'right'
    self.animation = Animation(gPlayerAnimations['idle'])
    self.state = StateMachine {
            -- general
        ['idle'] = function() return PlayerIdleState() end,
        ['run'] = function() return PlayerRunState() end,
        ['jump'] = function() return PlayerJumpState() end,
        ['fall'] = function() return PlayerFallState() end,
        ['sit'] = function() return PlayerSitState() end,
        ['death'] = function() return PlayerDeathState() end,
        ['crouch'] = function() return PlayerCrouchState() end,
        ['flip'] = function() return PlayerFlipState() end,
        ['pull_up'] = function() return PlayerPullUpState() end,
        ['hang'] = function() return PlayerHangState() end,
        ['walk'] = function() return PlayerWalkState() end,
        ['slide'] = function() return PlayerSlideState() end,
        ['sprint'] = function() return PlayerSprintState() end,
        ['slow'] = function() return PlayerSlowState() end,
            -- bow
        ['shoot_ground'] = function() return PlayerShootGroundState() end,
        ['shoot_jump'] = function() return PlayerShootJumpState() end,
        ['shoot_finish'] = function() return PlayerShootFinishState() end,
            -- combat
        ['kick'] = function() return PlayerKickState() end,
        ['punch_idle'] = function() return PlayerPunchIdleState() end,
        ['punch_run'] = function() return PlayerPunchRunState() end,
        ['pre_kick'] = function() return PlayerPreKickState() end,
        ['fall_kick'] = function() return PlayerFallKickState() end,
        ['get_up'] = function() return PlayerGetUpState() end,
        ['knock_down'] = function() return PlayerKnockDownState() end,
            -- sword
        ['attack_up'] = function() return PlayerAttackUpState() end,
        ['attack_down'] = function() return PlayerAttackDownState() end,
        ['attack_jump'] = function() return PlayerAttackJumpState() end,
        ['attack_fall'] = function() return PlayerAttackFallState() end,
        ['attack_run'] = function() return PlayerAttackRunState() end,
        ['pre_attack'] = function() return PlayerPreAttackState() end,
        ['swoop_attack'] = function() return PlayerSwoopAttackState() end,
        ['finish_attack'] = function() return PlayerFinishAttackState() end,
            -- magic
        ['cast_ground'] = function() return PlayerCastGroundState() end,
        ['cast_jump'] = function() return PlayerCastJumpState() end,
        ['cast_finish'] = function() return PlayerCastFinishState() end
    }

    self.health = self.world.playerHealth
    self.maxHealth = MAX_HEALTH
    self.mana = self.world.playerMana
    self.maxMana = MAX_MANA
    self.armor = self.world.playerArmor
    self.maxArmor = MAX_ARMOR
    self.agility = self.world.playerAgility
    self.maxAgility = MAX_AGILITY
    self.strength = self.world.playerStrength
    self.maxStrength = MAX_STRENGTH
    self.arrows = self.world.playerArrows
    self.maxArrows = MAX_ARROWS
    self.gameplayUI = GameplayUI(self)
end

function Player:update(dt)
    if self.y > VIRTUAL_HEIGHT then

        gSounds['gap']:play()

        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, FADE_IN_SPEED, self.world.camX,
        function()
            gStateStack:pop()
            
            LIVES = LIVES - 1
            if LIVES == 0 then
                gStateStack:push(GameOverState())
            else
                gStateStack:push(DeathState {
                    playerHealth = HEALTH_START,
                    playerMana = MANA_DEATH,
                    playerArmor = ARMOR_DEATH,
                    playerAgility = AGILITY_DEATH,
                    playerStrength = STRENGTH_DEATH,
                    playerArrows = self.arrows
                })
            end

            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, FADE_OUT_SPEED,
            function() end))
        end))  
    end

    if self.health == 0 and not self.dead then
        self.dy = 0
        self.state:change('death', self)
    end

    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt
        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
            self.inviolable = false
        end
    end
    
    if self.accelerated then
        self.acceleratedTimer = self.acceleratedTimer + dt
        if self.acceleratedTimer > self.acceleratedDuration then
            self.accelerated = false
            self.acceleratedTimer = 0
            self.acceleratedDuration = 0
            self.crouchSpeed = self.defaultCrouchSpeed
            self.walkSpeed = self.defaultWalkSpeed
            self.runSpeed = self.defaultRunSpeed
            self.sprintSpeed = self.defaultSprintSpeed
        end
    end

    if self.enlargeLight then
        self.enlargeLightTimer = self.enlargeLightTimer + dt
        if self.enlargeLightTimer > self.enlargeLightDuration then
            self.enlargeLight = false
            self.lightPower = self.defaultLightPower
            self.enlargeLightTimer = 0
            self.enlargeLightDuration = 0
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

    if self.invisible then
        self.invisibleTimer = self.invisibleTimer + dt
        if self.invisibleTimer > self.invisibleDuration then
            self.invisible = false
            self.invisibleTimer = 0
            self.invisibleDuration = 0
        end
    end

    if self.eating then
        self.eatingTimer = self.eatingTimer + dt
        if self.eatingTimer > self.eatingDuration then
            self.eating = false
            self.eatingTimer = 0
            self.eatingDuration = 0
        end
    end

    self.x = math.max(0, math.min(self.x + self.dx * dt, self.world.worldWidthPixels - self.width))
    self.y = self.y + self.dy * dt

    self.animation:update(dt)
    self.state:update(dt)
    self.gameplayUI:update(dt)
end

function Player:render()
    love.graphics.setColor(1, 1, 1, 1)

    if self.cursed then
        love.graphics.setShader(gShaders['curse'])
        gShaders['curse']:send("BlackFactor", 0.5)
    end
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setShader(gShaders['invulnerable_player'])
        gShaders['invulnerable_player']:send("WhiteFactor", 0.7)
    end
    if self.invisible then
        love.graphics.setColor(1, 1, 1, 64/255)
    end
    
    if not self.teleports then
        love.graphics.draw(self.texture,
            gFrames[self.animation.texture][self.animation:getCurrentFrame()], 
            math.floor(self.x + self.width / 2 - self.offsetX),
            math.floor(self.y + self.height / 2 - self.offsetY),
            0, 
            self.direction == 'right' and 1 or -1,
            1,
            self.width / 2, self.height / 2)
    end
    love.graphics.setShader()    
    love.graphics.setColor(1, 1, 1, 1)    
end

function Player:heal(heal)
    self.health = self.health + heal
    if self.health > self.maxHealth then
        self.health = self.maxHealth
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 0, g = 1, b = 0}, value = '+'..heal
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:getArmor(amount)
    self.armor = self.armor + amount
    if self.armor > self.maxArmor then
        self.armor = self.maxArmor
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 50/255, g = 140/255, b = 30/255}, value = '+'..amount
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:getAgility(amount)
    self.agility = self.agility + amount
    if self.agility > self.maxAgility then
        self.agility = self.maxAgility
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 234/255, g = 93/255, b = 38/255}, value = '+'..amount
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:getStrength(amount)
    self.strength = self.strength + amount
    if self.strength > self.maxStrength then
        self.strength = self.maxStrength
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 133/255, g = 60/255, b = 198/255}, value = '+'..amount
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:getMana(amount)
    self.mana = self.mana + amount
    if self.mana > self.maxMana then
        self.mana = self.maxMana
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 38/255, g = 107/255, b = 168/255}, value = '+'..amount
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:getArrows(amount)
    self.arrows = self.arrows + 5
    if self.arrows > self.maxArrows then
        self.arrows = self.maxArrows
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 1, g = 1, b = 1}, value = '+'..amount
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:damage(damage, type)    
    if type == 'health' then
        self.health = self.health - damage

    elseif type == 'armor' then
        if self.armor >= damage then
            self.armor = self.armor - damage

        elseif self.armor < damage then
            self.health = self.health - (damage - self.armor)
            self.armor = 0
        end
    end

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 1, g = 0, b = 0}, value = '-'..damage
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
    if self.health < 0 then
        self.health = 0
    end
end

function Player:goInvulnerable(duration, type, isBuff)
    self.invulnerable = true
    self.invulnerableDuration = duration
    self.inviolableType = type
    if isBuff then self.inviolable = true end
end

function Player:getAcceleration(duration, type)
    self.accelerated = true
    self.acceleratedDuration = duration
    self.acceleratedType = type
    self.crouchSpeed = self.increasedCrouchSpeed
    self.walkSpeed = self.increasedWalkSpeed
    self.runSpeed = self.increasedRunSpeed
    self.sprintSpeed = self.increasedSprintSpeed
end

function Player:getLight(duration)
    self.enlargeLightDuration = duration
    self.lightPower = self.enlargedLightPower
    self.enlargeLight = true
end

function Player:getCurse(duration)
    self.cursedDuration = duration
    self.cursed = true
    Timer.every(CURSE_INTERVAL_PLAYER, function () 
        if not self.dead then
            self:damage(CURSE_DAMAGE_PLAYER, 'health') 
        end
    end):limit(duration / CURSE_INTERVAL_PLAYER)
end

function Player:goInvisible(duration, type)
    self.invisibleDuration = duration
    self.invisible = true
    self.invisibleType = type
end

function Player:eat(duration, type, feed, isPoison)
    self.eatingType = type
    self.eatingDuration = duration
    self.eating = true
    Timer.every(EAT_INTERVAL, function ()
        if not self.dead then
            if feed == 'health' then 
                if isPoison then 
                    self:damage(POISONING_AMOUNT, 'health')
                else
                    self:heal(HEALTH_AMOUNT)
                end
            elseif feed == 'mana' then self:getMana(MANA_AMOUNT)
            elseif feed == 'agility' then self:getAgility(AGILITY_AMOUNT)
            elseif feed == 'strength' then self:getStrength(STRENGTH_AMOUNT)
            end
        end
    end):limit(duration / EAT_INTERVAL)
end

function Player:getLive()
    LIVES = LIVES + 1

    local popup = Popup {
        player = self, x = self.x + 3, y = self.y - 5,
        color = {r = 0, g = 1, b = 0}, value = '+1UP'
    }
    table.insert(self.gameplayUI.popups, popup)
    Timer.tween(POPUP_SPEED_LIVE, { [popup] = { y = self.y - 30 } }) :finish(function()
        table.remove(self.gameplayUI.popups, 1)
    end)
end

function Player:checkHookCollision()
    if self.direction == 'left' and self.world:hooks(self.world:tileAt(self.x - 1, self.y)) then

        gSounds['hook']:play()
        self.y = (self.world:tileAt(self.x - 1, self.y).y) * TILE_SIZE - TILE_SIZE
        self.dy = 0
        self.state:change('hang', self)

    elseif self.direction == 'right' and self.world:hooks(self.world:tileAt(self.x + self.width, self.y)) then

        gSounds['hook']:play()
        self.y = (self.world:tileAt(self.x + self.width, self.y).y) * TILE_SIZE - TILE_SIZE
        self.dy = 0
        self.state:change('hang', self)

    end
end

function Player:checkSideCollision()
    if self.dx < 0 then
        if self.world:collides(self.world:tileAt(self.x - 1, self.y)) or
            self.world:collides(self.world:tileAt(self.x - 1, self.y + self.height / 2)) or
                self.world:collides(self.world:tileAt(self.x - 1, self.y + self.height - 1)) then
            
            self.dx = 0
            self.x = self.world:tileAt(self.x - 1, self.y).x * TILE_SIZE
        end
    elseif self.dx > 0 then
        if self.world:collides(self.world:tileAt(self.x + self.width, self.y)) or
            self.world:collides(self.world:tileAt(self.x + self.width, self.y + self.height / 2)) or
                self.world:collides(self.world:tileAt(self.x + self.width, self.y + self.height - 1)) then
            
            self.dx = 0
            self.x = (self.world:tileAt(self.x + self.width, self.y).x - 1) * TILE_SIZE - self.width
        end
    end

    if self.y < 0 then
        if self.dx < 0 then
            if self.world:collides(self.world:tileAt(self.x - 1, 1)) then
                self.dx = 0
                self.x = self.world:tileAt(self.x - 1, 1).x * TILE_SIZE
            end
        else
            if self.world:collides(self.world:tileAt(self.x + self.width, 1)) then
                self.dx = 0
                self.x = (self.world:tileAt(self.x + self.width, 1).x - 1) * TILE_SIZE - self.width
            end
        end
    end
end

function Player:checkJumpingCollision()
    if self.world:collides(self.world:tileAt(self.x + 2, self.y)) or
        self.world:collides(self.world:tileAt(self.x + self.width - 3, self.y)) then
            
        self.dy = 0
        self.y = (self.world:tileAt(self.x + 2, self.y).y - 1) * TILE_SIZE + TILE_SIZE

        if self.state:getName() ~= 'shoot_jump' and self.state:getName() ~= 'cast_jump' then
            self.state:change('fall', self)
        end
    end
end

function Player:checkBottomCollision()
    if not self.world:collides(self.world:tileAt(self.x + 2, self.y + self.height)) and
        not self.world:collides(self.world:tileAt(self.x + self.width - 3, self.y + self.height)) then
        
        if not self.dead and not self.knocked then            
            self.state:change('fall', self)
        end
    end
end

function Player:checkLandingCollision()
    if self.world:collides(self.world:tileAt(self.x + 2, self.y + self.height)) or
        self.world:collides(self.world:tileAt(self.x + self.width - 3, self.y + self.height)) then
        
        if not self.dead and not self.knocked then
            gSounds['land']:play()
        end
        
        if self.dy > PLAYER_HIGH_LIMIT and not self.invulnerable then
            gSounds['high']:play()
            self:damage(FALL_DAMAGE, 'health')
            self:goInvulnerable(1.5)
            Event.dispatch('fall')
        end

        self.dy = 0
        self.y = (self.world:tileAt(self.x + 2, self.y + self.height).y - 1) * TILE_SIZE - self.height
        
        if not self.dead and not self.knocked then

            if self.state:getName() == 'swoop_attack' then
                self.state:change('finish_attack', self)

            elseif self.state:getName() == 'shoot_jump' and not self.launched then
                self.state:change('shoot_finish', self)
            
            elseif self.state:getName() == 'cast_jump' and not self.casted then
                    self.state:change('cast_finish', self)

            else
                self.state:change('idle', self)

            end

        end
    end
end

function Player:checkThornCollision()
    if not self.low then        
        if self.world:collides(self.world:thornAt(self.x + self.width - 2, self.y + self.height - 2)) or
            self.world:collides(self.world:thornAt(self.x + 2, self.y + self.height - 2)) or
                self.world:collides(self.world:thornAt(self.x + self.width - 2, self.y + 2)) or
                    self.world:collides(self.world:thornAt(self.x + 2, self.y + 2)) then

            if not self.invulnerable then
                gSounds['thorn']:stop()
                gSounds['thorn']:play()
                self:damage(THORN_DAMAGE, 'armor')
                self:goInvulnerable(1.5)
                Event.dispatch('thorn')
            end
        end
    else
        if self.world:collides(self.world:thornAt(self.x + self.width - 2, self.y + self.height - 2)) or
            self.world:collides(self.world:thornAt(self.x + 2, self.y + self.height - 2)) then

            if not self.invulnerable then
                gSounds['thorn']:stop()
                gSounds['thorn']:play()
                self:damage(THORN_DAMAGE, 'armor')
                self:goInvulnerable(1.5)
                Event.dispatch('thorn')
            end
        end
    end
end

function Player:checkObjectCollision()
    for o, object in pairs(self.world.objects) do
        if object:collides(self) then
            if object.restorable then
                if not object.hidden then
                    object.hidden = true
                    object.onConsume(self)
                end
            else
                object.onConsume(self)
                table.remove(self.world.objects, o)                      
            end     
        end
    end
end

function Player:checkEnemyCollision()
    for e, enemy in pairs(self.world.enemies) do
        if enemy:collides(self) and not enemy.dead then
            if self.cursed then
                if not enemy.cursed then
                    enemy:getCurse(CURSE_DURATION_ENEMY)
                    Event.dispatch('enemy_curse')
                end
            elseif not self.invulnerable and not enemy.invulnerable and not enemy.death and
                self.state:getName() ~= 'swoop_attack' and self.state:getName() ~= 'fall_kick' and
                self.state:getName() ~= 'slide' and self.state:getName() ~= 'punch_run' and
                self.state:getName() ~= 'attack_run' and self.state:getName() ~= 'finish_attack' then

                gSounds['collide']:stop()
                gSounds['collide']:play()
                self:damage(gDamageAmount[tostring(enemy.type) .. '_collide'], 'armor')
                self:goInvulnerable(1.5)
                Event.dispatch('enemy_touch')
            end
        end
    end
end