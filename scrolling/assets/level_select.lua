level_select = gideros.class(Sprite)



function level_select:init()
	
	 if not level then level=1 end
	 
	----init Scroll--------------------------------------------------------
	local slider = Scroll.new({step=400,vertical=nil,speed=40})
	self:addChild(slider)
	------------------------------------------------------------
	
	for i=1,10 do
		local group = Sprite.new()
		-- add element scroll---------------------------------
		slider:add(group)
		
		--BUTTON--------------
		box_btn = Button.new(Bitmap.new(Texture.new("images/crate.png")))
				box_btn:addEventListener("click", function(e)
					e:stopPropagation()
					print("element:"..i)
					level=slider.cur
					Room(level_1,21,31)
					
				end)
		group:addChild(box_btn)
		 box_btn:setAnchorPoint(0.5,0.5)
		box_btn:setScale(2)
		----------------------		
		local clickme_pic=Bitmap.new(Texture.new("images/button_down.png"))
		group:addChild(clickme_pic)
		clickme_pic:setAnchorPoint(0.5,0.5)
		clickme_pic:setScale(0.3)
		
	end
	 
	slider:gotoItem(level)  --перейти на поточний елемент
	slider:setPosition(centrX,centrY)	
	-----add_scroll------------------------------------------
	local scr=slider:add_scroll({
	img_off="images/noun_radio button_1.png",
	img_on="images/noun_radio button_2.png",
	step=40
							})
	-----------------------------------------------
	self:addChild(scr)
	scr:setAnchorPoint(0.5,0)
	scr:setPosition(centrX,30)	
	------------------------------------------
	leftarr_btn = Button.new(Bitmap.new(Texture.new("images/left-up.png")))
				leftarr_btn:addEventListener("click", function(e)
					e:stopPropagation()
					
					 slider:gotoItem(slider.cur-1)
					 
				end)
	self:addChild(leftarr_btn)
	leftarr_btn:setAnchorPoint(0.5,0.5)
	leftarr_btn:setPosition(minX+50,maxY-50)
	-------------------------------------------
	rightarr_btn = Button.new(Bitmap.new(Texture.new("images/right-up.png")))
				rightarr_btn:addEventListener("click", function(e)
					e:stopPropagation()
					
					 slider:gotoItem(slider.cur+1)
					  
				end)
	self:addChild(rightarr_btn)
	rightarr_btn:setAnchorPoint(0.5,0.5)
	rightarr_btn:setPosition(maxX-50,maxY-50)
	--slider:gotoItem(3)
	
end
