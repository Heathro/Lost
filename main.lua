--[[
    "Lost"

    Author: Andrei Gerasjov
    Location: Liverpool, UK
]]

require 'src/util/Dependencies'

local FPS = 60
local timerSleep = function () return 1/FPS end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	if love.timer then love.timer.step() end
 
	local dt = 0
 
	while true do
		
		local startT = love.timer.getTime()
		
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		if love.update then love.update(dt) end
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then
			local endT = love.timer.getTime()
			love.timer.sleep(timerSleep() - (endT - startT))
		end
	end
 
end

function love.load()
    love.mouse.setVisible(false)
    love.window.setTitle('Lost')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = false,
        fullscreen = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(LogoState())    
    EVENT_HANDLER = Events(0)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

function love.draw()
    Push:start()
    gStateStack:render()
    Push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keyboard.wasReleased(key)
    return love.keyboard.keysReleased[key]
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.resize(w, h)
    Push:resize(w, h)
end