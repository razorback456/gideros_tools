--[[
клас кнопки  -- вдключити мультитач
ВИКОРИСТАННЯ:
------------------------------------

	local score=Bitmap.new(Texture.new("img/gui_70.png"))
	score:setAnchorPoint(0.5, 0)
	score:setPosition(halfWidth, miny)
	self:addChild(score)
	 
	local pause = Button.new(Bitmap.new(Texture.new("img/gui_48.png")))
	stage:addChild(pause)


	pause:addEventListener("clickDown", 
		function(e)	
		e:stopPropagation()
			knopka:play()
		end)
		
	pause:addEventListener("clickUP", 
		function(e)	
		e:stopPropagation()
			knopka:play()
			 
		end)	
		pause:addEventListener("clickMove", 
		function(e)	
		print(e.x) 
			 
			 
		end)	
-------------------------------------
]]

minX,minY,maxX,maxY=application:getLogicalBounds()

-- ЗМІННІ
centrX =application:getContentWidth()/2
centrY =application:getContentHeight()/2


-----
Button = gideros.class(Sprite)

function Button:init(upState)
	self:addChild(upState)
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self.on=false
end



 function Button:onTouchesBegin(event)
 
	if self:hitTestPoint(event.touch.x, event.touch.y) then
	
		if event.touch.id~=self.focus then 
			self.focus=event.touch.id
			
			if self.on==false then
			 
				 
				self:dispatchEvent(Event.new("clickDown"))
				self.on=true
				self:setColorTransform(2, 2, 2, 1)
			end
			--print("natysnuv"..event.touch.id)
		end
		event:stopPropagation()
	end

end

 function Button:onTouchesMove(event)
	if self:hitTestPoint(event.touch.x, event.touch.y) then
	 
		if self.focus~=event.touch.id then
			self.focus=event.touch.id
			
			--print("move")
			
			if self.on==false then
				
				self:dispatchEvent(Event.new("clickDown"))
				self.on=true
				self:setColorTransform(2, 2, 2, 1)
				---print("naviv"..event.touch.id)
			
					
			end
		else
					 
					local clickMove = Event.new("clickMove")
					clickMove.x = event.touch.x
					clickMove.y = event.touch.y
					self:dispatchEvent(clickMove)
		end
	--event:stopPropagation()
	elseif self.focus==event.touch.id then
		--print("vidviv"..event.touch.id)
		self.focus=nil
		if self.on==true then
			self.on=false
			self:setColorTransform(1, 1, 1, 1)
		end
		event:stopPropagation()
	end
	
end

 function Button:onTouchesEnd(event)
 	--  якшо кнопка нажата на паузі 
								conf.v=nil
								conf.x=nil
								conf.y=nil
	if self:hitTestPoint(event.touch.x, event.touch.y) then
	
		self.focus=nil
		
		if self.on==true then
			
			self.on=false
			self:setColorTransform(1, 1, 1, 1)
			self:dispatchEvent(Event.new("clickUP"))
			--print("vidtysnuv"..event.touch.id)
		end
		--event:stopPropagation()
	else
		if self.focus==event.touch.id then
			self:setColorTransform(1, 1, 1, 1)
			self.focus=nil
		end
	end
	
end


