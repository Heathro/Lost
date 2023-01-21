--[[
    Shaders
]]

gShaders = {
    ['invulnerable_player'] = love.graphics.newShader[[
        extern float WhiteFactor;

        vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
        {
            vec4 outputcolor = Texel(tex, texcoord) * vcolor;
            outputcolor.rgb += vec3(WhiteFactor);
            return outputcolor;
        }
    ]],
    ['invulnerable_enemy'] = love.graphics.newShader[[
        extern float RedFactor;

        vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
        {
            vec4 outputcolor = Texel(tex, texcoord) * vcolor;
            outputcolor.rgb = vec3(RedFactor, 0.0, 0.0);
            return outputcolor;
        }
    ]],
    ['curse'] = love.graphics.newShader[[
        extern float BlackFactor;

        vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
        {
            vec4 outputcolor = Texel(tex, texcoord) * vcolor;
            outputcolor.rgb -= vec3(BlackFactor);
            return outputcolor;
        }
    ]],
    ['light'] = love.graphics.newShader[[
        #define NUM_LIGHTS 32
        struct Light {
            vec2 position;
            vec3 diffuse;
            float power;
        };
        extern Light lights[NUM_LIGHTS];
        extern int num_lights;
        extern vec2 screen;
        const float constant = 1.0;
        const float linear = 0.09;
        const float quadratic = 0.032;
        vec4 effect(vec4 color, Image image, vec2 uvs, vec2 screen_coords){
            vec4 pixel = Texel(image, uvs);
            vec2 norm_screen = screen_coords / screen;
            vec3 diffuse = vec3(0);
            for (int i = 0; i < num_lights; i++) {
                Light light = lights[i];
                vec2 norm_pos = light.position / screen;
                float distance = length(norm_pos - norm_screen) * light.power;
                float attenuation = 1.0 / (constant + linear * distance + quadratic * (distance * distance));
                diffuse += light.diffuse * attenuation;
            }
            diffuse = clamp(diffuse, 0.0, 1.0);
            return pixel * vec4(diffuse, 1.0);
        }
    ]]
}