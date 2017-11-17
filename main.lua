--! file: main.lua

function love.load()
  
   love.window.setTitle('stars')
   width, height = love.graphics.getDimensions( )
   listOfPoints = {}
   listOfLines = {}

end

function createPoint()
   point = {}
   point.x = width / 2 + math.random(-1,1)
   point.y = height / 2 + math.random(-1,1)
   point.speedx = math.random(-200, 200)
   point.speedy = math.random(-200, 200)

   --Put the new point in the list
   table.insert(listOfPoints, point)
end

function createLine()
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

   for i=0, 10 do
      createPoint()
   end

   for i=0, 10 do
      createLine()
   end

   for i,v in ipairs(listOfPoints) do
      if v.x < 0 or v.x > width or v.y < 0 or v.y > height then
         table.remove(listOfPoints, i)
      end
   end

   for i,v in ipairs(listOfLines) do
      if v.x1 < 0 or v.x1 > width or v.y1 < 0 or v.y1 > height then
         table.remove(listOfLines, i)
      end
   end

   for i,v in ipairs(listOfPoints) do
      v.x = v.x + v.speedx * dt
      v.y = v.y + v.speedy * dt
   end

   for i,v in ipairs(listOfLines) do
      v.x1 = v.x1 + v.speedx * dt
      v.y1 = v.y1 + v.speedy * dt
      v.x2 = v.x2 + v.speedx * dt
      v.y2 = v.y2 + v.speedy * dt
   end

end

function love.draw()

   for i,v in ipairs(listOfPoints) do
      love.graphics.points(v.x, v.y)
   end

   for i,v in ipairs(listOfLines) do
      love.graphics.line(v.x1, v.y1, v.x2, v.y2)
   end

   -- print the number of stars on  the screen
   love.graphics.print("nb of stars " .. #listOfPoints, 0, 0)
   love.graphics.print("nb of shotting stars " .. #listOfLines, 0, 15)
   love.graphics.print("FPS: ".. tostring(love.timer.getFPS( )), 0, 30)


end
-- 