--[[
Scale by gesture
 
клас Масштабування жестом
v.1.0   https://simartinfo.blogspot.com/p/v.html
author (c)https://www.facebook.com/AndroidMobileGame
ВИКОРИСТАННЯ:
------------------------------------
using:
--Lupa.new(mode)
 
        local Sprite1=Lupa.new(1)
        stage:addChild(Sprite1)
 
mode - 1 -2   пеетягувати спрайт 1 або 2 пальцями
-------------------------------------



]]
Lupa = gideros.class(Sprite)

function Lupa:init(mode)

----ПАРАМEТРИ лімітів ----------------------------------------
--коли відпускаєш палець спрайт плавно повертається в ліміти
--------------------------------------------------------------
local maxScale=2.5  -- максимальний масштаб
local minScale=0.7
local v_border=100  -- макимальна позиція від краю за як спрайт не вийде
local h_bordr=100
------------------------
self.h_bordr=h_bordr
self.v_border=v_border
self.maxScale=maxScale
self.minScale=minScale

	 if mode then
		self.m=mode
	 else
		self.m=2
	 end
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesEnd, self)
	 
end



 function Lupa:onTouchesBegin(event)
	if event.touch.id==1 then
		self.startY=event.touch.y
		self.startX=event.touch.x
	elseif event.touch.id==2 then
		self.startY2=event.touch.y
		self.startX2=event.touch.x
		self.on=true
	end

end

 function Lupa:onTouchesMove(event)
	if conf.pauza==false then
	if event.touch.id==1 then
 
		-- ПЕРЕМІЩЕННЯ 1
		if (self.m==1 and self.startX) or   (self.m>1 and self.on and self.startX) then
		
		if self.cx then -- для якоря між пальцями
			if self.cXo then
				self:setPosition(self:getX()+self.cx-self.cXo,self:getY()+self.cy-self.cYo)
			end
			self.cXo=self.cx
			self.cYo=self.cy
		else
			self:setPosition(self:getX()+event.touch.x-self.startX,self:getY()+event.touch.y-self.startY)
		end
			
		
		end
		
		self.startY=event.touch.y
		self.startX=event.touch.x
 
		--------------------------------
		--встановити якір на палець 1
		--------------------------------
		if self.on then
			local  s=self:getScale() --масштаб
			local ax,ay=self:getAnchorPosition()  --старі координати якоря  
			--поправка на масштаб
			ax=ax*s
			ay=ay*s
			local px,py=self:getPosition() -- координати спрайта
			--найти верхній лівий край 
			local kx=px-ax
			local ky=py-ay
			 
			local cy= self.startY -(self.startY -self.startY2)/2  --для якоря між пальцями
			local cx= self.startX  -(self.startX -self.startX2)/2
			self.cx=cx
			self.cy=cy
			
			-- новий якір
			local ax2=cx-kx	  
			local ay2=cy-ky		  
			
		
			self:setAnchorPosition(ax2/s,ay2/s) --встановити новий якір s-поправка на масштаб
			self:setPosition(px+(ax2-ax),py+(ay2-ay)) -- коригувати позицію спрайту згідно нового якоря
			
		end
		----------------------------------

	elseif event.touch.id==2 then

		self.startY2=event.touch.y
		self.startX2=event.touch.x
		----------------------------------
		-- дистанція між пальцем 1 і 2 
		if self.on and self.startX then
			self.d2= math.sqrt((self.startX-event.touch.x)^2+(self.startY-event.touch.y)^2)  
			if self.d then
				 self:setScale(self:getScaleX()*( self.d2/self.d))   -- масштаб
			end
			self.d=self.d2
		end
		----------------------------------
	end

end	
end

 function Lupa:onTouchesEnd(event)
	--ВИМКНУТИ ЯКЩО 1 ПАЛЕЦЬ ВІДПУСТИТИ
	if event.touch.id==1 or event.touch.id==2 then
		self.on=nil
		self.d=nil
		self.startY=nil
		self.startX=nil
		
		self.cx=nil   -- для якоря між пальцями
		self.cXo=nil
		self.cy=nil
		self.cYo=nil
		
		
		-- обмеження розмірів
		if self:getScaleX()>self.maxScale then --максимальний розмір
			 speed_scale(self,self.maxScale,self.maxScale,1000)
		elseif self:getScaleX()<self.minScale then -- мнімальний розмір
			speed_scale(self,self.minScale,self.minScale,1000)
		end
		-----------------------------------
		-- обмеження положення
		local  s=self:getScale() --масштаб
		local ax,ay=self:getAnchorPosition()  --старі координати якоря  
			--поправка на масштаб
			ax=ax*s
			ay=ay*s
			local px,py=self:getPosition() -- координати спрайта
			--найти верхній лівий край 
			local kx=px-ax -- лівий край
			local ky=py-ay  --верхній край
			local kx2=kx+self:getWidth()  -- правий край
			local ky2=ky+self:getHeight()  -- нижній край
			--print(self:getWidth(),kx,ky)
			-- self.h_bordr   -- боковий кордон кордон
			--	self.v_border  -- верхній кордон
			
			if kx2<minX+self.h_bordr then
				 x_mov=px+(minX+self.h_bordr-kx2)
				 
			end	
			if ky2<minY+self.v_border then
				 y_mov=py+(minY+self.v_border-ky2)
				 
			end	
			if kx>maxX-self.h_bordr then
				if x_mov then
					x_mov=nil -- якщшо кордон далі центру щоб не зациклювалось
				else
					 x_mov=px+(maxX-self.h_bordr-kx)
				end	
			end	
			if ky>maxY-self.v_border then
				if y_mov then
					y_mov=nil -- якщшо кордон далі центру щоб не зациклювалось
				else
					 y_mov=py+(maxY-self.v_border-ky)
				end	
			end	
			
			
			if x_mov or y_mov  then
				if not y_mov then y_mov=self:getY()  
				elseif not x_mov then x_mov=self:getX() end 
				
				speed_move(self,x_mov,y_mov,200)
				x_mov=nil
				y_mov=nil
			end
		-----------------------------------
		
		
		
	end
end

