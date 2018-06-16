
 
local kartinka = Bitmap.new(Texture.new("img/Tileset-Pack-1-Sheet_15.png"))
stage:addChild(kartinka)
local kartinka = Bitmap.new(Texture.new("img/Tileset-Pack-1-Sheet_25.png"))
kartinka:setY(30)
stage:addChild(kartinka)

--slice9.new(img,x,y,w,h,mode)
local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_15.png",5,8,-1,1,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(20,100)
 Sprite1:setX(10)
 
local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_15.png",5,8,-1,1,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(60,25)
 Sprite1:setX(40)
 
 local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_09.png",9,8,-1,6)
 stage:addChild(Sprite1)
 Sprite1:goSize(60,25)
 Sprite1:setY(40)
  Sprite1:setX(40)
  
   local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_25.png",-1,1,1,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(30,30)
 Sprite1:setY(70)
  Sprite1:setX(40)