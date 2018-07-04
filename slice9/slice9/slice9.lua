
--[[
 
 
клас slice9
v.1.1  
author (c)Oleg Simonenko
https://www.facebook.com/SimArt.info

--variant 1  class ----------------------
--slice9.new(img,x,y,w,h,mode)
local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_15.png",5,8,0,0,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(25,24)
 

--variant 2  object -----------------
  
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
 
 -- var3  flip 
 local Sprite1=slice9.new("img/Tileset-Pack-1-Sheet_15.png",5,8,-1,1,1)
 stage:addChild(Sprite1)
 Sprite1:goSize(20,100)
 Sprite1:setX(10)

]]

slice9 = gideros.class(Sprite)

function slice9:init(img,x,y,w,h,mode)
--  -h  відзеркалити
--mode  tile - 1-adaptive, 2-continuos
local ws,hs,ax,ay

if img[1] then
	ax=img[2]
	ay=img[3]
	ws=img[4]
	hs=img[5]
	--print(hs)
	img=img[1]
else
	ax=0
	ay=0
end

	if mode then self.vp={} end
	
	self.texture = Texture.new(img)
	
	if not ws then 	
		ws,hs = self.texture:getWidth(),self.texture:getHeight() 
	end
	
	 
	if w<0 then  fw=1 w=0 end
	if h<0 then  fh=1 h=0 end
	if x<0 then  fw=2 x=0 end
	if y<0 then  fh=2 y=0 end
	self.d={x,y,ws,hs,mode,w,h,fh,fw}
	 fh,fw=nil
	print(ax+0, ay+0, ax+x, ay+y)
	print(ax+x, ay+0, ax+ws-w-x, ay+y)
	print(ax+ws-w, ay+0, ax+w, ay+y)
	
	self.T1 =  TextureRegion.new(self.texture, ax+0, ay+0, x, y) 
	self.T2 =  TextureRegion.new(self.texture, ax+x, ay+0, ws-w-x, y)
	self.T3 =  TextureRegion.new(self.texture, ax+ws-w, ay+0, w, y) 
	
	
	self.T4 =  TextureRegion.new(self.texture, ax+0 , ay+y, x, hs-h-y) 
	self.T5 = TextureRegion.new(self.texture, ax+x, ay+y, ws-w-x, hs-h-y) 
	self.T6 =  TextureRegion.new(self.texture, ax+ws-w, ay+y, w, hs-h-y) 
	
	self.T7 =  TextureRegion.new(self.texture, ax+0, ay+hs-h, x, h) 
	self.T8 =  TextureRegion.new(self.texture, ax+x, ay+hs-h, ws-w-x, h)  
	self.T9 =  TextureRegion.new(self.texture, ax+ws-w, ay+hs-h, w, h)
	
	self.b1 =  Bitmap.new(self.T1)
	self.b2 =  Bitmap.new(self.T2)
	self.b3 =  Bitmap.new(self.T3)
	
	self.b4 =  Bitmap.new(self.T4)
	self.b5 =  Bitmap.new(self.T5)
	self.b6 =  Bitmap.new(self.T6)
	
	self.b7 =  Bitmap.new(self.T7)
	self.b8 =  Bitmap.new(self.T8)
	self.b9 =  Bitmap.new(self.T9)
	
	self.b1:setPosition(0,0)
	self.b2:setPosition(x,0)
	self.b3:setPosition(ws-w,0)
	 
	self.b4:setPosition(0,y)
	self.b5:setPosition(x,y)
	self.b6:setPosition(ws-w,y)
	
	self.b7:setPosition(0,hs-h)
	self.b8:setPosition(x,hs-h)
	self.b9:setPosition(ws-w,hs-h)
	 
	 self.group2 = Sprite.new()
	 self:addChild(self.group2)
	 
	 self.group1 = Sprite.new()
	 self.group2:addChild(self.group1)
	 
		self.group1:addChild(self.b1)
		self.group1:addChild(self.b2)
		self.group1:addChild(self.b3)
		
		self.group1:addChild(self.b4)
		self.group1:addChild(self.b5)
		self.group1:addChild(self.b6)
		
		self.group1:addChild(self.b7)
		self.group1:addChild(self.b8)
		self.group1:addChild(self.b9)	 
		
end


function slice9:goSize(ww,hh)
	 if self.d[9] then ww=ww/2 end
	  if self.d[8] then hh=hh/2 end
	 --self.d={x,y,ws,hs,m,w,h}
	--print(self.d[3],self.d[4])
	--ws-(x+w)  серединка стара
	--ww-(x+w  нова)
	--scale=стара\нову
	--
	--sh= w-self.d[3]
	--self.d={x,y,ws,hs,mode,w,h,fh,fw}
	-- print(self.d[5])
		local oldW=self.d[3]-self.d[1]-self.d[6]
		local oldH=self.d[4]-self.d[2]-self.d[7]
		local newW=ww-self.d[1]-self.d[6]
		local newH=hh-self.d[2]-self.d[7]
		local scaleW=newW/oldW
		local scaleH=newH/oldH
		
		self.b3:setX(ww-self.b3:getWidth() )
		self.b6:setX(ww-self.b6:getWidth() )
		self.b7:setY(hh-self.b7:getHeight() )
		self.b8:setY(hh-self.b8:getHeight() )
		self.b9:setX(ww-self.b9:getWidth() )
		self.b9:setY(hh-self.b9:getHeight() )
		
		
		local function sk()
			self.b2:setScaleX(scaleW) 
			self.b4:setScaleY(scaleH) 
			self.b5:setScaleX(scaleW)
			self.b5:setScaleY(scaleH)
			
			self.b6:setScaleY(scaleH) 
			
			self.b8:setScaleX(scaleW)
		end	
	if self.d[5] then
		-----------------------
		--адаптивні тайли
		-----------------------
		--print("tile")
		local numW=newW/oldW --кількість тайлів
		local numH=newH/oldH 
		 
		local adaptiveW=math.floor(numW+0.5) -- костиль щоб отримати аналог округлення  math.round(numW)
		local adaptiveH=math.floor(numH+0.5)
			scaleW=newW/(oldW*adaptiveW)
			scaleH=newH/(oldH*adaptiveH)
		
		--print("ada",scaleW)
		--print("тайлів",math.floor(numW+0.5))
		
		if #self.vp>0 then
			for i=1,#self.vp do
				self.vp[i]:removeFromParent()
				self.vp[i]=nil
			end
		
		end
			 
				
			
		 
			 
			local sw={self.b2,self.b5,self.b8}
			for i=1,adaptiveW-1 do
				for k=1,3 do
					self.vp[#self.vp+1]=Viewport.new()
					self.vp[#self.vp]:setContent(sw[k])
					self.vp[#self.vp]:setPosition(oldW*scaleW*i,0) 
					self.group1:addChild(self.vp[#self.vp])
				
				end
				
			end
			 sw={self.b4,self.b5,self.b6}
			for i=1,adaptiveH-1 do
				for k=1,3 do
					self.vp[#self.vp+1]=Viewport.new()
					self.vp[#self.vp]:setPosition(0,oldH*scaleH*i) 
					self.vp[#self.vp]:setContent(sw[k])
					self.group1:addChild(self.vp[#self.vp])
				
				end
			end
			for ih=1,adaptiveH-1 do
				for iw=1,adaptiveW-1 do
					self.vp[#self.vp+1]=Viewport.new()
					self.vp[#self.vp]:setPosition(oldW*scaleW*iw,oldH*scaleH*ih) 
					self.vp[#self.vp]:setContent(self.b5)
					self.group1:addChild(self.vp[#self.vp])
				
				end
			end
			
		 sk()
	else
		
		sk()
		
		
	end
	-------------------------------
	--self.d={x,y,ws,hs,mode,w,h,fh,fw}
	
if self.d[9] then   --фліп горизонтально
	
		---
		if self.fl_w then
			self.fl_w:removeFromParent()
			self.fl_w=nil
		end
		---
		self.fl_w=Viewport.new()
		if self.d[9]==1 then 
			self.fl_w:setX(self.group1:getWidth()*2) 
		else
			self.group2:setX(self.group1:getWidth())
		end
		 
		 
		self.fl_w:setContent(self.group1)
		self.fl_w:setScaleX(-1)
		self.group2:addChild(self.fl_w)
	
	end
	
	if self.d[8] then  --фліп вертикально
		---
		if self.fl_h then
			self.fl_h:removeFromParent()
			self.fl_h=nil
		end
		---
	
		self.fl_h=Viewport.new()
		if self.d[8]==1 then 
			self.fl_h:setY(self.group2:getHeight()*2) 
		else
			 
			self.group1:setY(self.group1:getHeight())
			self.fl_h:setY(self.group2:getHeight()*2)
			 
		end
		 
		 
		self.fl_h:setContent(self.group2)
		self.fl_h:setScaleY(-1)
		self:addChild(self.fl_h)
	
	end
end


 
function slise9(i,x,y,w,h,m)
	 
	return (function(px,py,pw,ph,r)	
			--print (i,x,y,w,h)
			
			local s=slice9.new(i,x,y,w,h,m)
			 s:goSize(pw,ph)
			 s:setPosition(px,py)
			 --print(r)
			 if r then s:setRotation(r) end
			return s
			end)
end
