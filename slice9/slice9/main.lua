


 --[[

--slice9.new(img,x,y,w,h,mode)
--slice9.new({atlas,x,y,w,h},x,y,w,h,mode)
local Sprite1=slice9.new({"img/17.png",33,22,95,50},0,0,0,0,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(400,100)
 Sprite1:setY(100) 
 
 Sprite1:setScale(2)
 ]]
 
 
 wall=slise9({"img/17.png",33,22,40,40},0,0,0,0,1)
 
--slise_name(x,y,w,h,[r])
 stage:addChild(wall(10,100,400,100))