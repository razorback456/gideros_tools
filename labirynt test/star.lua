
---------------------------------------------------------
dot = Bitmap.new(Texture.new("target.png"))
dot:setAnchorPoint(0.5, 0.5)
dot:setScale(0.5)
room2:addChild(dot)  -----ТОЧКА ПРИЦЕЛА
dot:setPosition(400,240 )   --  приціл



-------------------------------------------------
application:setBackgroundColor(0x2712F3 )

star = Core.class(Sprite)

function star:init(x,y,num)

 self.kartinka = Bitmap.new(Texture.new("zvzd1.png"))
self:addChild( self.kartinka)
 self.kartinka:setAnchorPoint(0.5,0.5)
 self.kartinka:setScale(0.5)
self:setPosition(x,y)

self.x = x
self.y = y
self.n = num

if num==1 then  self.col = 1 else self.col=0 end
end