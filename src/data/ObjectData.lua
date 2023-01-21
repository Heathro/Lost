--[[
    ObjectData
]]

gObjectFrame = {
    ['small_red_potion'] = 230,
    ['small_blue_potion'] = 231,
    ['small_green_potion'] = 232,
    ['small_purple_potion'] = 234,
    ['small_orange_potion'] = 235,
    ['small_pink_potion'] = 236,
    ['small_empty_potion'] = 237,
    ['medium_red_potion'] = 238,
    ['medium_blue_potion'] = 239,
    ['medium_green_potion'] = 240,
    ['medium_purple_potion'] = 242,
    ['medium_orange_potion'] = 243,
    ['medium_pink_potion'] = 244,
    ['medium_empty_potion'] = 245,
    ['large_red_potion'] = 246,
    ['large_blue_potion'] = 247,
    ['large_green_potion'] = 248,
    ['large_purple_potion'] = 250,
    ['large_orange_potion'] = 251,
    ['large_pink_potion'] = 252,
    ['large_empty_potion'] = 253,
    ['bronze_armor'] = 1,
    ['silver_armor'] = 2,
    ['gold_armor'] = 4,
    ['bronze_shoe'] = 64,
    ['silver_shoe'] = 65,
    ['gold_shoe'] = 67,
    ['black_scroll'] = 270,
    ['yellow_scroll'] = 274,
    ['blue_candy'] = 94,
    ['purple_candy'] = 96,
    ['orange_candy'] = 97,
    ['cookie'] = 125,
    ['red_fish'] = 142,
    ['yellow_fish'] = 143,
    ['green_fish'] = 144,
    ['apple'] = 148,
    ['banana'] = 149,
    ['life'] = 352,
    ['arrow'] = 15
}

gObjectConsume = {
    -- [[ SMALL POTION ]]
    ['small_red_potion'] = function(player, object)
        player:heal(10) -- amount of healing
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('red_potion')
    end,
    ['small_blue_potion'] = function(player, object)
        player:getMana(10) -- amount of mana increase
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('blue_potion')
    end,
    ['small_green_potion'] = function(player, object)
        player:damage(10, 'health') -- amount of damage, target of damage
        player:goInvulnerable(1.5) -- duration of invulnerability
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('green_potion')
    end,
    ['small_purple_potion'] = function(player, object)
        player:getStrength(10) -- amount of strength increase
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('purple_potion')
    end,
    ['small_orange_potion'] = function(player, object)
        player:getAgility(10) -- amount of agility increase
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('orange_potion')
    end,
    ['small_pink_potion'] = function(player, object)
        player:goInvulnerable(3, gObjectFrame['small_pink_potion'], true)
        -- duration of invulnerability, icon for ui, isBuff 
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('pink_potion')
    end,
    ['small_empty_potion'] = function(player, object)
        player:goInvisible(3, gObjectFrame['small_empty_potion'])
        -- duration of invisibility, icon for ui
        gSounds['potion_small']:stop()
        gSounds['potion_small']:play()
        Event.dispatch('empty_potion')
    end,

    -- [[ MEDIUM POTION ]]
    ['medium_red_potion'] = function(player, object)
        player:heal(20) -- amount of healing
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('red_potion')
    end,
    ['medium_blue_potion'] = function(player, object)
        player:getMana(20) -- amount of mana increase
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('blue_potion')
    end,
    ['medium_green_potion'] = function(player, object)
        player:damage(20, 'health') -- amount of damage, target of damage
        player:goInvulnerable(1.5) -- duration of invulnerability
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('green_potion')
    end,
    ['medium_purple_potion'] = function(player, object)
        player:getStrength(20) -- amount of strength increase
        Event.dispatch('purple_potion')
    end,
    ['medium_orange_potion'] = function(player, object)
        player:getAgility(20) -- amount of agility increase
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('orange_potion')
    end,
    ['medium_pink_potion'] = function(player, object)
        player:goInvulnerable(5, gObjectFrame['medium_pink_potion'], true)
        -- duration of invulnerability, icon for ui, isBuff 
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('pink_potion')
    end,
    ['medium_empty_potion'] = function(player, object)
        player:goInvisible(5, gObjectFrame['medium_empty_potion'])
        -- duration of invisibility, icon for ui
        gSounds['potion_medium']:stop()
        gSounds['potion_medium']:play()
        Event.dispatch('empty_potion')
    end,

    -- [[ LARGE POTION ]]
    ['large_red_potion'] = function(player, object)
        player:heal(30) -- amount of healing
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('red_potion')
    end,
    ['large_blue_potion'] = function(player, object)
        player:getMana(30) -- amount of mana increase
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('blue_potion')
    end,
    ['large_green_potion'] = function(player, object)
        player:damage(30, 'health') -- amount of damage, target of damage
        player:goInvulnerable(1.5) -- duration of invulnerability
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('green_potion')
    end,
    ['large_purple_potion'] = function(player, object)
        player:getStrength(30) -- amount of strength increase
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('purple_potion')
    end,
    ['large_orange_potion'] = function(player, object)
        player:getAgility(30) -- amount of agility increase
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('orange_potion')
    end,
    ['large_pink_potion'] = function(player, object)
        player:goInvulnerable(8, gObjectFrame['large_pink_potion'], true)
        -- duration of invulnerability, icon for ui, isBuff 
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('pink_potion')
    end,
    ['large_empty_potion'] = function(player, object)
        player:goInvisible(8, gObjectFrame['large_empty_potion'])
        -- duration of invisibility, icon for ui
        gSounds['potion_large']:stop()
        gSounds['potion_large']:play()
        Event.dispatch('empty_potion')
    end,

    -- [[ ARMOR ]]
    ['bronze_armor'] = function(player, object)
        player:getArmor(20) -- amount of armor increase
        gSounds['armor']:stop()
        gSounds['armor']:play()
        Event.dispatch('armor')
    end,
    ['silver_armor'] = function(player, object)
        player:getArmor(50) -- amount of armor increase
        gSounds['armor']:stop()
        gSounds['armor']:play()
        Event.dispatch('armor')
    end,
    ['gold_armor'] = function(player, object)
        player:getArmor(80) -- amount of armor increase
        gSounds['armor']:stop()
        gSounds['armor']:play()
        Event.dispatch('armor')
    end,

    -- [[ SHOE ]]
    ['bronze_shoe'] = function(player, object)
        player:getAcceleration(3, gObjectFrame['bronze_shoe'])
        -- duration of acceleration, icon for ui
        gSounds['shoe']:stop()
        gSounds['shoe']:play()
        Event.dispatch('shoe')
    end,
    ['silver_shoe'] = function(player, object)
        player:getAcceleration(5, gObjectFrame['silver_shoe'])
        -- duration of acceleration, icon for ui
        gSounds['shoe']:stop()
        gSounds['shoe']:play()
        Event.dispatch('shoe')
    end,
    ['gold_shoe'] = function(player, object)
        player:getAcceleration(8, gObjectFrame['gold_shoe'])
        -- duration of acceleration, icon for ui
        gSounds['shoe']:stop()
        gSounds['shoe']:play()
        Event.dispatch('shoe')
    end,

    -- [[ SCROLL ]]
    ['black_scroll'] = function(player, object)
        player:getCurse(8) -- duration of curse
        gSounds['scroll']:stop()
        gSounds['scroll']:play()
        Event.dispatch('black_scroll')
    end,
    ['yellow_scroll'] = function(player, object)
        player:getLight(8) -- duration of light enlarge
        gSounds['scroll']:stop()
        gSounds['scroll']:play()
        Event.dispatch('yellow_scroll')
    end,

    -- [[ CANDY ]]
    ['blue_candy'] = function(player, object)
        player:eat(10, gObjectFrame['blue_candy'], 'mana')
        -- duration of eating, icon for ui, stats to increase
        gSounds['candy']:stop()
        gSounds['candy']:play()
        Event.dispatch('candy')
    end,
    ['purple_candy'] = function(player, object)
        player:eat(10, gObjectFrame['purple_candy'], 'strength')
        -- duration of eating, icon for ui, stats to increase
        gSounds['candy']:stop()
        gSounds['candy']:play()
        Event.dispatch('candy')
    end,
    ['orange_candy'] = function(player, object)
        player:eat(10, gObjectFrame['orange_candy'], 'agility')
        -- duration of eating, icon for ui, stats to increase
        gSounds['candy']:stop()
        gSounds['candy']:play()
        Event.dispatch('candy')
    end,

    -- [[ FOOD ]]
    ['cookie'] = function(player, object)
        player:eat(8, gObjectFrame['cookie'], 'health')
        -- duration of eating, icon for ui, stats to increase
        gSounds['food']:stop()
        gSounds['food']:play()
        Event.dispatch('food')
    end,
    ['red_fish'] = function(player, object)
        player:eat(10, gObjectFrame['red_fish'], 'health')
        -- duration of eating, icon for ui, stats to increase
        gSounds['fish']:stop()
        gSounds['fish']:play()
        Event.dispatch('food')
    end,
    ['yellow_fish'] = function(player, object)
        player:eat(5, gObjectFrame['yellow_fish'], 'health')
        -- duration of eating, icon for ui, stats to increase
        gSounds['fish']:stop()
        gSounds['fish']:play()
        Event.dispatch('food')
    end,
    ['green_fish'] = function(player, object)
        player:eat(8, gObjectFrame['green_fish'], 'health', true)
        -- duration of eating, icon for ui, stats to increase, isPoison
        gSounds['fish']:stop()
        gSounds['fish']:play()
        Event.dispatch('food_poison')
    end,
    ['apple'] = function(player, object)
        player:eat(4, gObjectFrame['apple'], 'health')
        -- duration of eating, icon for ui, stats to increase
        gSounds['food']:stop()
        gSounds['food']:play()
        Event.dispatch('food')
    end,
    ['banana'] = function(player, object)
        player:eat(4, gObjectFrame['banana'], 'health')
        -- duration of eating, icon for ui, stats to increase
        gSounds['food']:stop()
        gSounds['food']:play()
        Event.dispatch('food')
    end,

    -- [[ EXTRA ]]
    ['life'] = function(player, object)
        player:getLive()
        gSounds['life']:setVolume(0.2)
        gSounds['life']:stop()
        gSounds['life']:play()
        Event.dispatch('life')
    end,
    ['arrow'] = function(player, object)
        player:getArrows(5) -- amount of arrows to collect
        gSounds['arrow']:stop()
        gSounds['arrow']:play()
        Event.dispatch('arrow')
    end
}