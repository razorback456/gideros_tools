
--[[
 
 
клас slice9
v.1.0  
author (c)Oleg Simonenko
https://www.facebook.com/SimArt.info



]]

slice9 = gideros.class(Sprite)

function slice9:init(img,x,y,w,h,mode)
--  -h  відзеркалити
--mode  tile - 1-adaptive, 2-continuos


	if mode then self.vp={} end
	
	self.texture = Texture.new(img)
	local ws,hs = self.texture:getWidth(),self.texture:getHeight()
	if w<0 then local fw=1 w=0 end
	if h<0 then local fh=1 h=0 end
	if x<0 then local fh=2 x=0 end
	if y<0 then local fw=2 y=0 end
	self.d={x,y,ws,hs,mode,w,h,fh,fw}
	
	
	self.T1 =  TextureRegion.new(self.texture, 0, 0, x, y) 
	self.T2 =  TextureRegion.new(self.texture, x, 0, ws-w-x, y)
	self.T3 =  TextureRegion.new(self.texture, ws-w, 0, w, y) 
	
	
	self.T4 =  TextureRegion.new(self.texture, 0 , y, x, hs-h-y) 
	self.T5 = TextureRegion.new(self.texture, x, y, ws-w-x, hs-h-y)
	self.T6 =  TextureRegion.new(self.texture, ws-w, y, w, hs-h-y) 
	
	self.T7 =  TextureRegion.new(self.texture, 0, hs-h, x, h) 
	self.T8 =  TextureRegion.new(self.texture, x, hs-h, ws-w-x, h)  
	self.T9 =  TextureRegion.new(self.texture, ws-w, hs-h, w, h)
	
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
	 
	 
		self:addChild(self.b1)
		self:addChild(self.b2)
		self:addChild(self.b3)
		
		self:addChild(self.b4)
		self:addChild(self.b5)
		self:addChild(self.b6)
		
		self:addChild(self.b7)
		self:addChild(self.b8)
		self:addChild(self.b9)	 
end


function slice9:goSize(ww,hh)
	 
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
					self:addChild(self.vp[#self.vp])
				
				end
				
			end
			 sw={self.b4,self.b5,self.b6}
			for i=1,adaptiveH-1 do
				for k=1,3 do
					self.vp[#self.vp+1]=Viewport.new()
					self.vp[#self.vp]:setPosition(0,oldH*scaleH*i) 
					self.vp[#self.vp]:setContent(sw[k])
					self:addChild(self.vp[#self.vp])
				
				end
			end
			for ih=1,adaptiveH-1 do
				for iw=1,adaptiveW-1 do
					self.vp[#self.vp+1]=Viewport.new()
					self.vp[#self.vp]:setPosition(oldW*scaleW*iw,oldH*scaleH*ih) 
					self.vp[#self.vp]:setContent(self.b5)
					self:addChild(self.vp[#self.vp])
				
				end
			end
			
		 sk()
	else
		
		sk()
		
		
	end
	
	
end


 
function slise9(i,x,y,w,h,m)
	 
	return (function(px,py,pw,ph,r)	
			--print (i,x,y,w,h)
			
			local s=slice9.new(i,x,y,w,h,m)
			 s:goSize(pw,ph)
			 s:setPosition(px,py)
			 print(r)
			 if r then s:setRotation(r) end
			return s
			end)
end