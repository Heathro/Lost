--[[
    EnemyData
]]

gEnemyHealth = {
    ['slime_health'] = 10,
    ['slime_maxHealth'] = 10,
    ['earth_wisp_health'] = 20,
    ['earth_wisp_maxHealth'] = 20,
    ['fire_wisp_health'] = 20,
    ['fire_wisp_maxHealth'] = 20,
    ['water_wisp_health'] = 20,
    ['water_wisp_maxHealth'] = 20,
    ['wind_wisp_health'] = 20,
    ['wind_wisp_maxHealth'] = 20,

    ['goblin_health'] = 35,
    ['goblin_maxHealth'] = 35,
    ['kobold_health'] = 40,
    ['kobold_maxHealth'] = 40,
    ['mimic_health'] = 30,
    ['mimic_maxHealth'] = 30,
    ['minotaur_health'] = 60,
    ['minotaur_maxHealth'] = 60,
    ['oculothorax_health'] = 25,
    ['oculothorax_maxHealth'] = 25,
    ['ogre_health'] = 50,
    ['ogre_maxHealth'] = 50
}

gDamageAmount = {
    ['slime_collide'] = 10,
    ['slime_attack'] = 15,
    ['earth_wisp_collide'] = 15,
    ['earth_wisp_attack'] = 25,
    ['fire_wisp_collide'] = 15,
    ['fire_wisp_attack'] = 25,
    ['water_wisp_collide'] = 15,
    ['water_wisp_attack'] = 25,
    ['wind_wisp_collide'] = 15,
    ['wind_wisp_attack'] = 25,

    ['goblin_collide'] = 30,
    ['goblin_attack'] = 40,
    ['kobold_collide'] = 35,
    ['kobold_attack'] = 45,
    ['mimic_collide'] = 25,
    ['mimic_attack'] = 35,
    ['minotaur_collide'] = 50,
    ['minotaur_attack'] = 60,
    ['oculothorax_collide'] = 20,
    ['oculothorax_attack'] = 30,
    ['ogre_collide'] = 40,
    ['ogre_attack'] = 50
}

gKnockChance = {
    ['slime'] = 15,
    ['earth_wisp'] = 10,
    ['fire_wisp'] = 10,
    ['water_wisp'] = 10,
    ['wind_wisp'] = 10,

    ['goblin'] = 6,
    ['kobold'] = 5,
    ['mimic'] = 7,
    ['minotaur'] = 3,
    ['oculothorax'] = 6,
    ['ogre'] = 4
}

gEnemySpeed = {
    ['slime_move'] = 5,
    ['slime_catch'] = 15,
    ['earth_wisp_move'] = 15,
    ['earth_wisp_catch'] = 25,
    ['fire_wisp_move'] = 15,
    ['fire_wisp_catch'] = 25,
    ['water_wisp_move'] = 15,
    ['water_wisp_catch'] = 25,
    ['wind_wisp_move'] = 15,
    ['wind_wisp_catch'] = 25,

    ['goblin_move'] = 25,
    ['goblin_catch'] = 40,
    ['kobold_move'] = 35,
    ['kobold_catch'] = 50,
    ['mimic_move'] = 20,
    ['mimic_catch'] = 30,
    ['minotaur_move'] = 35,
    ['minotaur_catch'] = 50,
    ['oculothorax_move'] = 15,
    ['oculothorax_catch'] = 25,
    ['ogre_move'] = 25,
    ['ogre_catch'] = 40
}

gEnemySizes = {
    ['slime_width'] = 28,
    ['slime_height'] = 14,
    ['earth_wisp_width'] = 28,
    ['earth_wisp_height'] = 26,
    ['fire_wisp_width'] = 26,
    ['fire_wisp_height'] = 26,
    ['water_wisp_width'] = 22,
    ['water_wisp_height'] = 26,
    ['wind_wisp_width'] = 22,
    ['wind_wisp_height'] = 26,

    ['goblin_width'] = 28,
    ['goblin_height'] = 32,

    ['kobold_width'] = 38,
    ['kobold_height'] = 30,

    ['mimic_width'] = 30,
    ['mimic_height'] = 32,

    ['minotaur_width'] = 72,
    ['minotaur_height'] = 46,

    ['oculothorax_width'] = 26,
    ['oculothorax_height'] = 22,

    ['ogre_width'] = 36,
    ['ogre_height'] = 34
}

gEnemyOffsets = {
    ['slime_idle_x'] = 0,
    ['slime_idle_y'] = 0,
    ['slime_move_x'] = 0,
    ['slime_move_y'] = 0,
    ['slime_hurt_x'] = 0,
    ['slime_hurt_y'] = 1,
    ['slime_attack_x'] = 0,
    ['slime_attack_y'] = 6,
    ['slime_die_x'] = 2,
    ['slime_die_y'] = 2,

    ['earth_wisp_idle_x'] = 0,
    ['earth_wisp_idle_y'] = 0,
    ['earth_wisp_move_x'] = 0,
    ['earth_wisp_move_y'] = 0,
    ['earth_wisp_hurt_x'] = -1,
    ['earth_wisp_hurt_y'] = 1,
    ['earth_wisp_attack_x'] = 6,
    ['earth_wisp_attack_y'] = 10,
    ['earth_wisp_die_x'] = 1,
    ['earth_wisp_die_y'] = 1,

    ['fire_wisp_idle_x'] = 0,
    ['fire_wisp_idle_y'] = 4,
    ['fire_wisp_move_x'] = 0,
    ['fire_wisp_move_y'] = 0,
    ['fire_wisp_hurt_x'] = -1,
    ['fire_wisp_hurt_y'] = 1,
    ['fire_wisp_attack_x'] = 2,
    ['fire_wisp_attack_y'] = 13,
    ['fire_wisp_die_x'] = 1,
    ['fire_wisp_die_y'] = 6,

    ['water_wisp_idle_x'] = 0,
    ['water_wisp_idle_y'] = 0,
    ['water_wisp_move_x'] = 0,
    ['water_wisp_move_y'] = 0,
    ['water_wisp_hurt_x'] = 0,
    ['water_wisp_hurt_y'] = 0,
    ['water_wisp_attack_x'] = 3,
    ['water_wisp_attack_y'] = 0,
    ['water_wisp_die_x'] = 1,
    ['water_wisp_die_y'] = 0,

    ['wind_wisp_idle_x'] = 0,
    ['wind_wisp_idle_y'] = 0,
    ['wind_wisp_move_x'] = 0,
    ['wind_wisp_move_y'] = 0,
    ['wind_wisp_hurt_x'] = 0,
    ['wind_wisp_hurt_y'] = 0,
    ['wind_wisp_attack_x'] = 5,
    ['wind_wisp_attack_y'] = 9,
    ['wind_wisp_die_x'] = 5,
    ['wind_wisp_die_y'] = 10,

    ['goblin_idle_x'] = 0,
    ['goblin_idle_y'] = 0,
    ['goblin_move_x'] = 0,
    ['goblin_move_y'] = 0,
    ['goblin_hurt_x'] = 0,
    ['goblin_hurt_y'] = -1,
    ['goblin_die_x'] = 14,
    ['goblin_die_y'] = -1,
    ['goblin_attack_x'] = 0,
    ['goblin_attack_y'] = 1,

    ['kobold_idle_x'] = 0,
    ['kobold_idle_y'] = 0,
    ['kobold_move_x'] = 0,
    ['kobold_move_y'] = 0,
    ['kobold_hurt_x'] = -1,
    ['kobold_hurt_y'] = 0,
    ['kobold_die_x'] = 3,
    ['kobold_die_y'] = -1,
    ['kobold_attack_x'] = 10,
    ['kobold_attack_y'] = 0, 

    ['mimic_idle_x'] = 0,
    ['mimic_idle_y'] = 0,
    ['mimic_move_x'] = 0,
    ['mimic_move_y'] = 0,
    ['mimic_hurt_x'] = 0,
    ['mimic_hurt_y'] = -2,
    ['mimic_die_x'] = 1,
    ['mimic_die_y'] = -2,
    ['mimic_attack_x'] = 2,
    ['mimic_attack_y'] = 0,

    ['minotaur_idle_x'] = 0,
    ['minotaur_idle_y'] = 0,
    ['minotaur_move_x'] = 0,
    ['minotaur_move_y'] = 3,
    ['minotaur_hurt_x'] = 0,
    ['minotaur_hurt_y'] = -2,
    ['minotaur_die_x'] = 0,
    ['minotaur_die_y'] = 29,
    ['minotaur_attack_x'] = 4,
    ['minotaur_attack_y'] = 29, 

    ['oculothorax_idle_x'] = 0,
    ['oculothorax_idle_y'] = 0,
    ['oculothorax_move_x'] = 0,
    ['oculothorax_move_y'] = 0,
    ['oculothorax_hurt_x'] = -2,
    ['oculothorax_hurt_y'] = 0,
    ['oculothorax_die_x'] = 0,
    ['oculothorax_die_y'] = 3,
    ['oculothorax_attack_x'] = 2,
    ['oculothorax_attack_y'] = 8,

    ['ogre_idle_x'] = 0,
    ['ogre_idle_y'] = 1,
    ['ogre_move_x'] = 0,
    ['ogre_move_y'] = -2,
    ['ogre_hurt_x'] = 0,
    ['ogre_hurt_y'] = 0,
    ['ogre_die_x'] = 0,
    ['ogre_die_y'] = 6,
    ['ogre_attack_x'] = 5,
    ['ogre_attack_y'] = 4
}

gAttackFrame = {
    ['slime'] = 3,
    ['earth_wisp'] = 7,
    ['fire_wisp'] = 7,
    ['water_wisp'] = 7,
    ['wind_wisp'] = 7,
    
    ['goblin'] = 3,
    ['kobold'] = 3,
    ['mimic'] = 7,
    ['minotaur'] = 6,
    ['oculothorax'] = 4,
    ['ogre'] = 4
}

gEnemyAnimations = {
    ['slime_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'slime_idle'
    },
    ['slime_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'slime_move'
    },
    ['slime_attack'] = {
        frames = {1, 2, 3, 4, 5, 5},
        interval = 0.2,
        looping = false,
        texture = 'slime_attack'
    },
    ['slime_hurt'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.2,
        looping = false,
        texture = 'slime_hurt'
    },
    ['slime_die'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.2,
        looping = false,
        texture = 'slime_die'
    },

    ['earth_wisp_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'earth_wisp_idle'
    },
    ['earth_wisp_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'earth_wisp_move'
    },
    ['earth_wisp_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.13,
        looping = false,
        texture = 'earth_wisp_attack'
    },
    ['earth_wisp_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'earth_wisp_hurt'
    },
    ['earth_wisp_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.2,
        looping = false,
        texture = 'earth_wisp_die'
    },

    ['fire_wisp_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.17,
        looping = true,
        texture = 'fire_wisp_idle'
    },
    ['fire_wisp_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'fire_wisp_move'
    },
    ['fire_wisp_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.13,
        looping = false,
        texture = 'fire_wisp_attack'
    },
    ['fire_wisp_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'fire_wisp_hurt'
    },
    ['fire_wisp_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.2,
        looping = false,
        texture = 'fire_wisp_die'
    },

    ['water_wisp_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'water_wisp_idle'
    },
    ['water_wisp_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'water_wisp_move'
    },
    ['water_wisp_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.13,
        looping = false,
        texture = 'water_wisp_attack'
    },
    ['water_wisp_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'water_wisp_hurt'
    },
    ['water_wisp_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.2,
        looping = false,
        texture = 'water_wisp_die'
    },

    ['wind_wisp_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'wind_wisp_idle'
    },
    ['wind_wisp_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'wind_wisp_move'
    },
    ['wind_wisp_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.13,
        looping = false,
        texture = 'wind_wisp_attack'
    },
    ['wind_wisp_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'wind_wisp_hurt'
    },
    ['wind_wisp_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.2,
        looping = false,
        texture = 'wind_wisp_die'
    },

    ['goblin_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'goblin_idle'
    },
    ['goblin_move'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.15,
        looping = true,
        texture = 'goblin_move'
    },
    ['goblin_hurt'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.25,
        looping = false,
        texture = 'goblin_hurt'
    },
    ['goblin_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 9},
        interval = 0.2,
        looping = false,
        texture = 'goblin_die'
    },
    ['goblin_attack'] = {
        frames = {1, 2, 3, 4, 5, 5},
        interval = 0.15,
        looping = false,
        texture = 'goblin_attack'
    },

    ['kobold_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'kobold_idle'
    },
    ['kobold_move'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.2,
        looping = true,
        texture = 'kobold_move'
    },
    ['kobold_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'kobold_hurt'
    },
    ['kobold_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.2,
        looping = false,
        texture = 'kobold_die'
    },
    ['kobold_attack'] = {
        frames = {1, 2, 3, 4, 5, 5},
        interval = 0.15,
        looping = false,
        texture = 'kobold_attack'
    },

    ['mimic_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'mimic_idle'
    },
    ['mimic_move'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.2,
        looping = true,
        texture = 'mimic_move'
    },
    ['mimic_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'mimic_hurt'
    },
    ['mimic_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.15,
        looping = false,
        texture = 'mimic_die'
    },
    ['mimic_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11},
        interval = 0.15,
        looping = false,
        texture = 'mimic_attack'
    },

    ['minotaur_idle'] = {
        frames = {1, 2, 3, 4, 5},
        interval = 0.17,
        looping = true,
        texture = 'minotaur_idle'
    },
    ['minotaur_move'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.25,
        looping = true,
        texture = 'minotaur_move'
    },
    ['minotaur_hurt'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.25,
        looping = false,
        texture = 'minotaur_hurt'
    },
    ['minotaur_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 8},
        interval = 0.2,
        looping = false,
        texture = 'minotaur_die'
    },
    ['minotaur_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10},
        interval = 0.15,
        looping = false,
        texture = 'minotaur_attack'
    },

    ['oculothorax_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'oculothorax_idle'
    },
    ['oculothorax_move'] = {
        frames = {1, 2, 3, 4},
        interval = 0.2,
        looping = true,
        texture = 'oculothorax_move'
    },
    ['oculothorax_hurt'] = {
        frames = {1, 2, 3, 4, 4},
        interval = 0.25,
        looping = false,
        texture = 'oculothorax_hurt'
    },
    ['oculothorax_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 8},
        interval = 0.2,
        looping = false,
        texture = 'oculothorax_die'
    },
    ['oculothorax_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 9},
        interval = 0.15,
        looping = false,
        texture = 'oculothorax_attack'
    },

    ['ogre_idle'] = {
        frames = {1, 2, 3, 4},
        interval = 0.23,
        looping = true,
        texture = 'ogre_idle'
    },
    ['ogre_move'] = {
        frames = {1, 2, 3, 4, 5, 6},
        interval = 0.2,
        looping = true,
        texture = 'ogre_move'
    },
    ['ogre_hurt'] = {
        frames = {1, 2, 3, 3},
        interval = 0.25,
        looping = false,
        texture = 'ogre_hurt'
    },
    ['ogre_die'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 9},
        interval = 0.2,
        looping = false,
        texture = 'ogre_die'
    },
    ['ogre_attack'] = {
        frames = {1, 2, 3, 4, 5, 6, 7, 7},
        interval = 0.15,
        looping = false,
        texture = 'ogre_attack'
    }
}