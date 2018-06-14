
--slice9.new(img,x,y,w,h,mode)
--local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_15.png",5,8,0,0,1)
 --stage:addChild(Sprite1)
 --Sprite1:goSize(25,24)
 

  
-- slise9(img,x,y,w,h,mode)
wall=slise9("img/brick_tiles_v2_01.png",8,8,8,1,1)
water=slise9("img/17.png",0,0,0,0,1)

--slise_name(x,y,w,h,[r])
 stage:addChild(wall(10,0,50,24))
 stage:addChild(wall(100,0,100,24))
 
 stage:addChild(wall(30,20,100,24,10))
 
 
 stage:addChild(water(0,50,200,50))
 stage:addChild(water(10,60,200,50))
 stage:addChild(water(77,99,200,50))