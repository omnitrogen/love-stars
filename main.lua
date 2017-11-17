--! file: main.lua

function love.load()
  
   love.window.setTitle('stars')
   width, height = love.graphics.getDimensions( )
   listOfPoints = {}

end

function createPoint()
   point = {}
   point.x = width / 2 
   point.y = height / 2
   point.width = math.random(20, 50)
   point.height = math.random(20, 50)
   point.speedx = math.random(-200, 200)
   point.speedy = math.random(-200, 200)

   --Put the new pointangle in the list
   table.insert(listOfPoints, point)
end

function love.update(dt)

   for i=0, 10 do
      createPoint()
   end

   for i,v in ipairs(listOfPoints) do
      if v.x < 0 or v.x > width or v.y < 0 or v.y > height then
         table.remove(listOfPoints, i)
      end
   end

   for i,v in ipairs(listOfPoints) do
      v.x = v.x + v.speedx * dt
      v.y = v.y + v.speedy * dt
   end

end

function love.draw()

   for i,v in ipairs(listOfPoints) do
      love.graphics.points(v.x, v.y)
   end

   -- print the number of stars on  the screen
   love.graphics.print(#listOfPoints)

end
-- 