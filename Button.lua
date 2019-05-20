--[[
   (c)Oleg Simonenko
www.facebook.com/SimArt.info
simartinfo.blogspot.com
github.com/razorback456/gideros_tools

клас кнопки  -- вдключити мультитач
ВИКОРИСТАННЯ:
------------------------------------


	 
	local pause = Button.new(Bitmap.new(Texture.new("img/gui_48.png")))
	stage:addChild(pause)


	pause:addEventListener("clickDown", 
		function(e)	
		e:stopPropagation()
			print("clickDown") 
		end)
		
	pause:addEventListener("clickUP", 
		function(e)	
		e:stopPropagation()
			print("clickUP") 
			 
		end)	
		pause:addEventListener("clickMove", 
		function(e)	
		print("clickMove "..e.x) 
			 
			 
		end)	
-------------------------------------
]]

minX,minY,maxX,maxY=application:getLogicalBounds()

-- ЗМІННІ
centrX =application:getContentWidth()/2
centrY =application:getContentHeight()/2


-----
Button = gideros.class(Sprite)

function Button:init(upState,ColorTransform)
	if ColorTransform then self.ColorTransform=ColorTransform end --відключити  трансформ кольору кнопки
	
	self:addChild(upState) -- додати спрайт кнопки
	
	
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self.on=false
end



 function Button:onTouchesBegin(event)
 
	if self:hitTestPoint(event.touch.x, event.touch.y) then
	--print(1)
		if event.touch.id~=self.focus then 
		--print(2)
			self.focus=event.touch.id
			
			if self.on==false then
			 --print(3)
				 
				self:dispatchEvent(Event.new("clickDown"))
				self.click=true --для функції click 
				self.on=true
				if not self.ColorTransform then
				self:setColorTransform(2, 2, 2, 1)
				end
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
				 self.click=nil --для функції click 
				self.on=true
				if not self.ColorTransform then
					self:setColorTransform(2, 2, 2, 1)
				end
				---print("naviv"..event.touch.id)
			
					
			end
		else
					 event:stopPropagation()
					local clickMove = Event.new("clickMove")
					self.click=nil --для функції click 
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
							--	conf.v=nil
								--conf.x=nil
								--conf.y=nil
	if self:hitTestPoint(event.touch.x, event.touch.y) then
	
		self.focus=nil
		
		if self.on==true then
			
			self.on=false
			self:setColorTransform(1, 1, 1, 1)
			self:dispatchEvent(Event.new("clickUP"))
			if self.click then self:dispatchEvent(Event.new("click")) end --для функції click 
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





