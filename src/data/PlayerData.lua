--[[
    PlayerData
]]

gPlayerAnimations = {
    ['idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'idle'
    },
    ['run'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.13,
        looping = true,
        texture = 'run'
    },
    ['jump'] = {
        frames = {1},
        interval = 0.2,
        looping = true,
        texture = 'jump'
    },
    ['fall'] = {
        frames = {1, 2},
        interval = 0.12,
        looping = true,
        texture = 'fall'
    },
    ['sit'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'sit'
    },
    ['crouch'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.175,
        looping = true,
        texture = 'crouch'
    },
    ['flip'] = {
        frames = {1, 2, 3, 4},
        interval = 0.12,
        looping = true,
        texture = 'flip'
    },
    ['walk'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.12,
        looping = true,
        texture = 'walk'
    },
    ['sprint'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.12,
        looping = true,
        texture = 'sprint'
    },
    ['death'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.2,
        looping = false,
        texture = 'death'
    },
    ['slide'] = {
        frames = {1, 2, 3, 4, 5},
        interval = 0.23,
        looping = false,
        texture = 'slide'
    },
    ['hang'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'hang'
    },
    ['pull_up'] = {
        frames = {1, 2, 3, 4, 5},
        interval = 0.1,
        looping = false,
        texture = 'pull_up'
    },
    ['slow'] = {
        frames = {1, 2},
        interval = 0.3,
        looping = true,
        texture = 'slow'
    },
    ['shoot_ground'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2},
        interval = 0.1,
        looping = false,
        texture = 'shoot_ground'
    },
    ['shoot_jump'] = {
        frames = {1, 2, 3, 4, 5, 6, 1},
        interval = 0.08,
        looping = false,
        texture = 'shoot_jump'
    },
    ['shoot_finish'] = {
        frames = {6, 7, 8, 9, 1, 2},
        interval = 0.08,
        looping = false,
        texture = 'shoot_ground'
    },
    ['kick'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 8},
        interval = 0.08,
        looping = false,
        texture = 'kick'
    },
    ['punch_idle'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 13},
        interval = 0.05,
        looping = false,
        texture = 'punch_idle'
    },
    ['punch_run'] = {
        frames = {1, 2, 3, 4, 4, 5, 6, 7, 7},
        interval = 0.1,
        looping = false,
        texture = 'punch_run'
    },
    ['pre_kick'] = {
        frames = {1},
        interval = 0.2,
        looping = true,
        texture = 'pre_kick'
    },
    ['fall_kick'] = {
        frames = {1, 2},
        interval = 0.2,
        looping = true,
        texture = 'fall_kick'
    },
    ['knock_down'] = {
        frames = {1, 2, 3, 4, 5, 6, 7},
        interval = 0.1,
        looping = false,
        texture = 'knock_down'
    },
    ['get_up'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.1,
        looping = false,
        texture = 'get_up'
    },
    ['attack_up'] = {
        frames = {1, 2, 3, 4, 5, 5},
        interval = 0.1,
        looping = false,
        texture = 'attack_up'
    },
    ['attack_down'] = {
        frames = {1, 2, 3, 4, 5, 6, 6},
        interval = 0.1,
        looping = false,
        texture = 'attack_down'
    },
    ['attack_jump'] = {
        frames = {1, 2, 3, 3},
        interval = 0.1,
        looping = false,
        texture = 'attack_jump'
    },
    ['attack_fall'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.1,
        looping = false,
        texture = 'attack_fall'
    },
    ['attack_run'] = {
        frames = {1, 2, 3, 3, 4, 5, 6, 6},
        interval = 0.1,
        looping = false,
        texture = 'attack_run'
    },
    ['pre_attack'] = {
        frames = {1},
        interval = 0.2,
        looping = true,
        texture = 'pre_attack'
    },
    ['swoop_attack'] = {
        frames = {1, 2},
        interval = 0.1,
        looping = true,
        texture = 'swoop_attack'
    },
    ['finish_attack'] = {
        frames = {1, 2, 3, 3},
        interval = 0.12,
        looping = false,
        texture = 'finish_attack'
    },
    ['cast_ground'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.12,
        looping = false,
        texture = 'cast'
    },
    ['cast_jump'] = {
        frames = {2, 3, 4, 4},
        interval = 0.12,
        looping = false,
        texture = 'cast'
    },
    ['cast_finish'] = {
        frames = {3, 4, 4},
        interval = 0.12,
        looping = false,
        texture = 'cast'
    }
}