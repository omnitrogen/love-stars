--! file: main.lua

function love.load()

	love.window.setFullscreen(true, "desktop")
	love.window.setTitle('stars')
	-- get window dimensions
	width, height = love.graphics.getDimensions( )
	listOfPoints = {}
	listOfLines = {}
	x, y = width/2, height/2

end

function createPoint()

	-- define stars
	point = {}
	point.x = width / 2 + math.random(-1,1)
	point.y = height / 2 + math.random(-1,1)
	point.speedx = math.random(-200, 200)
	point.speedy = math.random(-200, 200)

	--Put the new point in the list
	table.insert(listOfPoints, point)
end

function createLine()

	-- define shooting stars
	line = {}
	line.x1 = width / 2 
	line.y1 = height / 2
	line.speedx = math.random(-300, 300)
	line.speedy = math.random(-300, 300)
	line.x2 = (width / 2) + (line.speedx / math.random(8, 10))
	line.y2 = (height / 2)  + (line.speedy / math.random(8, 10))

	--Put the new line in the list
	table.insert(listOfLines, line)

end

function love.update(dt)

	if love.keyboard.isDown("left") then
		x = x - 300 * dt

	elseif love.keyboard.isDown("right") then
		x = x + 300 * dt

	elseif love.keyboard.isDown("up") then
		y = y - 300 * dt

	elseif love.keyboard.isDown("down") then
		y = y + 300 * dt
	end
	if love.keyboard.isDown("up") and love.keyboard.isDown("left") then
		y = y - 100 * dt
		x = x - 100 * dt
	elseif love.keyboard.isDown("up") and love.keyboard.isDown("right") then
		y = y - 100 * dt
		x = x + 100 * dt
	elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
		y = y + 100 * dt
		x = x - 100 * dt
	elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
		y = y + 100 * dt
		x = x + 100 * dt
	end

	-- create stars and shooting stars
	for i=0, 10 do
		createPoint()
		createLine()
	end

	-- if a star is out if the window then we delete it
	for i,v in ipairs(listOfPoints) do
		if v.x < 0 or v.x > width or v.y < 0 or v.y > height then
			table.remove(listOfPoints, i)
		end
		-- update star position
		v.x = v.x + v.speedx * dt
		v.y = v.y + v.speedy * dt
	end

	-- if a shooting star is out if the window then we delete it
	for i,v in ipairs(listOfLines) do
		if v.x1 < 0 or v.x1 > width or v.y1 < 0 or v.y1 > height then
			table.remove(listOfLines, i)
		end
		-- update shooting star position
		v.x1 = v.x1 + v.speedx * dt
		v.y1 = v.y1 + v.speedy * dt
		v.x2 = v.x2 + v.speedx * dt
		v.y2 = v.y2 + v.speedy * dt
	end
end

function love.draw()

	love.graphics.setColor(255, 255, 255, 255)
	-- draw stars
	for i,v in ipairs(listOfPoints) do
		love.graphics.points(v.x, v.y)
	end

	-- draw shooting stars
	for i,v in ipairs(listOfLines) do
		love.graphics.line(v.x1, v.y1, v.x2, v.y2)
	end

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.circle("fill", x, y, 25)

	love.graphics.setColor(255, 255, 255, 255)
	-- print the number of stars and shooting stars on  the screen
	love.graphics.print("nb of stars " .. #listOfPoints, 0, 0)
	love.graphics.print("nb of shooting stars " .. #listOfLines, 0, 15)
	-- print FPS
	love.graphics.print("FPS: ".. tostring(love.timer.getFPS( )), 0, 30)

end
--