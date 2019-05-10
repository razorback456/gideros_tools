Scroll = Core.class(Sprite)

function Scroll:init(arg)
	--print(arg.step)
	self.step=arg.step  -- відстань між елементами
	self.vert=arg.vertical  --горизонтальний або вертикальний скрол
	
	self.sp_movie=arg.speed  --швидкість анімації

	self.group = Sprite.new()
	--------------------------------------------
	self.group2 = Button.new(self.group,1)
		self.group2:addEventListener("clickMove", 
			function(e)	
			e:stopPropagation()
			if self.group.speed_move then self.group.speed_move:stop() end  --преривання анімації
			--print("clickMove "..e.x) 	 
			if self.vert then
				if self.move then  -- зчитати попередні координати
					self.speed= self.move-e.y
					self.move=self.speed
					self.group:setY(self.group:getY()-self.move)
					self.move=e.y
				else
					self.move=e.y
				end
			else
				if self.move then  -- зчитати попередні координати
				 self.speed= self.move-e.x
					self.move=self.speed
					self.group:setX(self.group:getX()-self.move)
					
					self.move=e.x
				else
					self.move=e.x
				end
			end
			self:specefect()  -- спецефекти  прозорості
		end)	
	---------------------------------------------------------------------
	self.group2:addEventListener("clickDown", 
		function(e)	
		--e:stopPropagation()
			--print("clickDown") 
			if self.group.speed_move then self.group.speed_move:stop() end  --преривання анімації
			
			self.group.speed_move=nil
		end)
	---------------------------------------------------------------------
	self.group2:addEventListener("clickUP", 
		function(e)	
		--e:stopPropagation()
			--print("clickUP") 
			if self.move then 
				self.move=nil
				-- self:fixItem()
				 --print("швидкість прокрутки",self.speed)
				-------------------------------------------------
				 self.group:addEventListener("endscroll",  --кінець анімації
										function(e)	
										e:stopPropagation()
										self:fixItem()
									
											end)
				----------------------------------------------							
					local y2,x2
					if not self.speed then self.speed=1 end  -- fix bug attempt to perform arithmetic on field 'speed' (a nil value)
					if self.vert then
						y2=self.group:getY()-8*self.speed
						x2= self.group:getX()
					else
						x2=self.group:getX()-8*self.speed
						y2= self.group:getY()
					end
					----------------------------------------------------
				 speed_move({
					sprite=self.group,
					
					 
						x2=x2,
						y2= y2,
					 
					speed=math.abs(self.speed*self.sp_movie),
					effect="outSine",
					event="endscroll"
					})
				----------------------------------------------
			 end
		end)	
	---------------------------------------------	
	self:addChild(self.group2)
	
	--self:gotoItem(self.cur)	
	
	
	
	 

end
--------Додати елемент---------------------------------
function Scroll:add(elem)
	
	self.group:addChild(elem)
	local c= self.group:getNumChildren()
	if self.vert then
		elem:setY((c-1)*self.step)
	else
		elem:setX((c-1)*self.step)
	end
	
end
-------Радіобокси скрола----------------------------------
function Scroll:add_scroll(arg)
	local p1=arg.img_off
	local p2=arg.img_on
	self.scroll_step=arg.step

	 self.scroll = Sprite.new()
	--self:addChild(self.scroll)

	for i=1,self.group:getNumChildren() do
		local pic=Bitmap.new(Texture.new(p1))
		self.scroll:addChild(pic)
		--pic:setAnchorPoint(0.5,0.5)
		 if self.vert then
			pic:setY((i-1)*self.scroll_step)
		 else
			pic:setX((i-1)*self.scroll_step)
		end
	end	
		self.raiobox=Bitmap.new(Texture.new(p2))
		self.scroll:addChild(self.raiobox)
		--pic:setAnchorPoint(0.5,0.5)
		 if self.vert then
			self.raiobox:setY((self.cur-1)*self.scroll_step)
		 else
			self.raiobox:setX((self.cur-1)*self.scroll_step)
		end
		
		return self.scroll
end

------Прокрутка на потрібний елемент----------------------------------
function Scroll:gotoItem(ind)
	
	
	self.cur=ind
	if self.vert then
		y2=-(ind-1)*self.step
		x2=self.group:getX()
	else
		x2=-(ind-1)*self.step
		y2= self.group:getY()
	end
	-------------------------------------------------
				 self.group:addEventListener("endgotoItem",  --кінець анімації
										function(e)	
										--e:stopPropagation()
										
										if self.cur<1 or self.cur> self.group:getNumChildren() then --обмеження початку і кінця
										
											self:fixItem()
										end
											if self.raiobox then -- радіобок бігунок
												if self.vert then
													self.raiobox:setY((self.cur-1)*self.scroll_step)
												else
													self.raiobox:setX((self.cur-1)*self.scroll_step)
												end
											end
											end)
										
	----------------------------------------------------
				 speed_move({
					sprite=self.group,
						x2=x2,
						y2= y2,
					speed=500,
					effect="outBounce",
					event="endgotoItem"
					})
				----------------------------------------------
	
	
	
end
---------------прокрутити до найближчого елемента--------------
function Scroll:fixItem()
	local ind
	if self.vert then
		 ind= math.floor((self.group:getY()/self.step)+0.5)*-1+1
	else
		 ind= math.floor((self.group:getX()/self.step)+0.5)*-1+1 
	end
	--math.floor(a+0.5)   -- правильне округлення чисел
	--self.group:getNumChildren()
	if ind<1 then ind=1 end  -- обмежувач початка
	if ind> self.group:getNumChildren() then ind=self.group:getNumChildren() end  --обмежувач кінця
	self:gotoItem(ind)
end
--------------------------------------
function Scroll:specefect()

	--self.group:getChildAt(1):setScale(1-math.abs(self.group:getX()/500))
	
	
end