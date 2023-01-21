--[[
    Events
]]

Events = Class {}

function Events:init(x)
    self.x = x

    RED_POTION_EVENT = Event.on('red_potion', function (dt)
        gStateStack:push(DialogueState(RED_POTION_TEXT, self.x))
        RED_POTION_EVENT:remove()
    end)

    BLUE_POTION_EVENT = Event.on('blue_potion', function (dt)
        gStateStack:push(DialogueState(BLUE_POTION_TEXT, self.x))
        BLUE_POTION_EVENT:remove()
    end)

    GREEN_POTION_EVENT = Event.on('green_potion', function (dt)
        gStateStack:push(DialogueState(GREEN_POTION_TEXT, self.x))
        GREEN_POTION_EVENT:remove()
    end)

    PURPLE_POTION_EVENT = Event.on('purple_potion', function (dt)
        gStateStack:push(DialogueState(PURPLE_POTION_TEXT, self.x))
        PURPLE_POTION_EVENT:remove()
    end)

    ORANGE_POTION_EVENT = Event.on('orange_potion', function (dt)
        gStateStack:push(DialogueState(ORANGE_POTION_TEXT, self.x))
        ORANGE_POTION_EVENT:remove()
    end)

    PINK_POTION_EVENT = Event.on('pink_potion', function (dt)
        gStateStack:push(DialogueState(PINK_POTION_TEXT, self.x))
        PINK_POTION_EVENT:remove()
    end)

    EMPTY_POTION_EVENT = Event.on('empty_potion', function (dt)
        gStateStack:push(DialogueState(EMPTY_POTION_TEXT, self.x))
        EMPTY_POTION_EVENT:remove()
    end)

    ARMOR_EVENT = Event.on('armor', function (dt)
        gStateStack:push(DialogueState(ARMOR_TEXT, self.x))
        ARMOR_EVENT:remove()
    end)

    SHOE_EVENT = Event.on('shoe', function (dt)
        gStateStack:push(DialogueState(SHOE_TEXT, self.x))
        SHOE_EVENT:remove()
    end)

    YELLOW_SCROLL_EVENT = Event.on('yellow_scroll', function (dt)
        gStateStack:push(DialogueState(YELLOW_SCROLL_TEXT, self.x))
        YELLOW_SCROLL_EVENT:remove()
    end)

    BLACK_SCROLL_EVENT = Event.on('black_scroll', function (dt)
        gStateStack:push(DialogueState(BLACK_SCROLL_TEXT, self.x))
        BLACK_SCROLL_EVENT:remove()
    end)

    CURSE_EVENT = Event.on('curse', function (dt)
        gStateStack:push(DialogueState(CURSE_TEXT, self.x))
        CURSE_EVENT:remove()
    end)

    FOOD_EVENT = Event.on('food', function (dt)
        gStateStack:push(DialogueState(FOOD_TEXT, self.x))
        FOOD_EVENT:remove()
    end)

    FOOD_POISON_EVENT = Event.on('food_poison', function (dt)
        gStateStack:push(DialogueState(FOOD_POISON_TEXT, self.x))
        FOOD_POISON_EVENT:remove()
    end)

    CANDY_EVENT = Event.on('candy', function (dt)
        gStateStack:push(DialogueState(CANDY_TEXT, self.x))
        CANDY_EVENT:remove()
    end)

    THORN_EVENT = Event.on('thorn', function (dt)
        gStateStack:push(DialogueState(THORN_TEXT, self.x))
        THORN_EVENT:remove()
    end)

    FALL_EVENT = Event.on('fall', function (dt)
        gStateStack:push(DialogueState(FALL_TEXT, self.x))
        FALL_EVENT:remove()
    end)

    KNOCK_EVENT = Event.on('knock', function (dt)
        gStateStack:push(DialogueState(KNOCK_TEXT, self.x))
        KNOCK_EVENT:remove()
    end)

    LIVE_EVENT = Event.on('life', function (dt)
        gStateStack:push(DialogueState(LIFE_TEXT, self.x))
        LIVE_EVENT:remove()
    end)

    ARROW_EVENT = Event.on('arrow', function (dt)
        gStateStack:push(DialogueState(ARROW_TEXT, self.x))
        ARROW_EVENT:remove()
    end)

    ENEMY_TOUCH_EVENT = Event.on('enemy_touch', function (dt)
        gStateStack:push(DialogueState(ENEMY_TOUCH_TEXT, self.x))
        ENEMY_TOUCH_EVENT:remove()
    end)

    ENEMY_CURSE_EVENT = Event.on('enemy_curse', function (dt)
        gStateStack:push(DialogueState(ENEMY_CURSE_TEXT, self.x))
        ENEMY_CURSE_EVENT:remove()
    end)
end

function Events:update(x)
    self.x = x
end